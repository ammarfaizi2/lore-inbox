Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270797AbRHWX7B>; Thu, 23 Aug 2001 19:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270796AbRHWX6l>; Thu, 23 Aug 2001 19:58:41 -0400
Received: from [216.151.155.121] ([216.151.155.121]:63751 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S270784AbRHWX6j>; Thu, 23 Aug 2001 19:58:39 -0400
To: Tony Hoyle <tmh@nothing-on.tv>
Cc: Fred <fred@arkansaswebs.com>, linux-kernel@vger.kernel.org
Subject: Re: File System Limitations
In-Reply-To: <01082316383301.12104@bits.linuxball> <9m41qd$290$1@sisko.my.home>
	<01082318132000.12319@bits.linuxball> <3B858F58.1000606@nothing-on.tv>
From: Doug McNaught <doug@wireboard.com>
Date: 23 Aug 2001 19:58:50 -0400
In-Reply-To: Tony Hoyle's message of "Fri, 24 Aug 2001 00:18:48 +0100"
Message-ID: <m3d75me3b9.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle <tmh@nothing-on.tv> writes:

> Fred wrote:
> > so why dos my filesystem have a 2 GB limit?
> > Must I specify a large block size or some such when i format?
> > i run 2.4.9 on redhat7.1 out of the box
> 
> >
> 
> Does it?  Unless RH are using a seriously old glibc (which I doubt)
> there's no 2GB limit any more.

I just did:

[doug@abbadon workspace]$ dd if=/dev/zero of=foo bs=1024k count=3072
3072+0 records in
3072+0 records out
[doug@abbadon workspace]$ ls -l foo  
-rw-rw-r--    1 doug     doug     3221225472 Aug 23 20:01 foo
[doug@abbadon workspace]$ 

-Doug
-- 
Free Dmitry Sklyarov! 
http://www.freesklyarov.org/ 

We will return to our regularly scheduled signature shortly.
