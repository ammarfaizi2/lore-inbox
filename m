Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTFXRY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTFXRY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:24:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17618 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262185AbTFXRY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:24:57 -0400
Date: Tue, 24 Jun 2003 19:39:00 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.73 compile results
Message-ID: <20030624173900.GV3710@fs.tum.de>
References: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1056475577.9839.110.camel@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 10:26:18AM -0700, John Cherry wrote:
> Compile statistics: 2.5.73
> Compiler: gcc 3.2.2
> Script: http://www.osdl.org/archive/cherry/stability/compregress.sh
> 
>           bzImage       bzImage        modules
>         (defconfig)  (allmodconfig) (allmodconfig)
> 
> 2.5.73  2 warnings    11 warnings   1347 warnings
>         0 errors       9 errors       43 errors
>...

Your counting is a bit strange, with bzImage of allmodconfig there's
exactly one compile error that is counted nine times (there are later 
eight errors since the file that failed to compile isn't present).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

