Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVA1K4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVA1K4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 05:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbVA1K4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 05:56:01 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21257 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261256AbVA1Kzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 05:55:55 -0500
Date: Fri, 28 Jan 2005 11:55:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Morris <jmorris@redhat.com>
Cc: Jasper Spaans <jasper@vs19.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ajgrothe@yahoo.com
Subject: Re: crypto algoritms failing?
Message-ID: <20050128105550.GL28047@stusta.de>
References: <20050128004755.GA6676@spaans.vs19.net> <Xine.LNX.4.44.0501272023080.7174-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501272023080.7174-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 08:43:18PM -0500, James Morris wrote:
> On Fri, 28 Jan 2005, Jasper Spaans wrote:
> 
> > On Thu, Jan 27, 2005 at 07:38:43PM -0500, James Morris wrote:
> > > > Is this supposed to happen?
> > > 
> > > No.  What is your kernel version?
> > 
> > Current bitkeeper + latest swsusp2 patches and hostap driver, however, those
> > two don't come near touching the crypto stuff[1] so they're not really on my
> > suspect shortlist, but I'll see if I can find time to build a vanilla one
> > tomorrow (that is, without swsusp/hostap).. right now, it's time to sleep in
> > my local timezone..
> 
> Looks like a cleanup broke the test vectors:
> http://linux.bkbits.net:8080/linux-2.5/gnupatch@41ad5cd9EXGuUhmmotTFBIZdIkTm0A
> 
> Patch below, please apply.
>...

Ops, yes, sorry.
Where are the broen paperbags?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

