Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTGBQxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 12:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTGBQxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 12:53:01 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2815 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264075AbTGBQw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 12:52:58 -0400
Date: Wed, 2 Jul 2003 19:07:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc 2.95.4 vs gcc 3.3 ?
Message-ID: <20030702170717.GW282@fs.tum.de>
References: <20030702141345.GD13653@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702141345.GD13653@rdlg.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 10:13:45AM -0400, Robert L. Harris wrote:
> 
>   I'm trying to compile the 2.4.21-ac3 kernel for some work machines.
> One of the users is insisting on gcc 3.3 to compile.  Reading the
> web page on www.kernel.org this is recomended against.
> 
>   Perchance is this old news, is the 3.3 compiled kernel going to kill
> something or anything that should be related to users or any bosses?

gcc 3.3 is relatively new and _much_ less tested than 2.95. A new gcc 
might either contain bugs or it might unleash bugs in the kernel that 
weren't visible before (e.g. via better optimizations).

Usually gcc 3.3 works fine (and my PC at home runs a 2.4.21 compiled
with 3.3) but if you want stability in production envvironments 2.95 (or
the unofficial 2.96 >= 2.96-74) is the recommended compiler.

> Robert

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

