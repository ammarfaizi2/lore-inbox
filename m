Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266059AbUAFBW3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 20:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266068AbUAFBW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 20:22:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34001 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266059AbUAFBW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 20:22:27 -0500
Date: Tue, 6 Jan 2004 02:22:23 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrea Barisani <lcars@infis.univ.trieste.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20040106012223.GD11523@fs.tum.de>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it> <20040105221732.GG10569@fs.tum.de> <20040105225954.GA9382@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105225954.GA9382@sole.infis.univ.trieste.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 11:59:54PM +0100, Andrea Barisani wrote:
> Hi!

Hi Andrea!

>...
> And I really think that MOUSEDEV should not be considered a 'not-standard'
> option. It's quite common disabling MOUSE support on servers, terminals and
> so on. :)

If the only effect of an unnecessaryly enabled option are a few kB 
wasted space, this isn't a big problem in most situations.

If it's easy to accidentially disable an important option, it's good to 
protect users against doing so.

People who _really_ need the space simply enable EMBEDDED to disable 
such an option.

> Bye and thanks

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

