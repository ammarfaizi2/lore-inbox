Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275565AbRIZUGc>; Wed, 26 Sep 2001 16:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275567AbRIZUGW>; Wed, 26 Sep 2001 16:06:22 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:37645 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275565AbRIZUGN>;
	Wed, 26 Sep 2001 16:06:13 -0400
Date: Wed, 26 Sep 2001 13:01:56 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010926130156.B19819@kroah.com>
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB229D1.10401@wirex.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 12:17:37PM -0700, Crispin Cowan wrote:
> Greg KH wrote:
> 
> >If you were to include a GPL licensed user space header file in a closed
> >source program, of course you would be violating that license.
> >
> That is not clear to me. I have been unable to find a definitive 
> reference that states that is the case.  If so, it is problematic, 
> because then every user-land program that ever #include'd errno.h from 
> glibc is GPL'd, because glibc #include's errno.h, among other GPL'd 
> kernel header files. Are you sure you want to declare nearly all 
> proprietary Linux applications to be in violation of the GPL?

That is an issue to take up with the glibc authors, not me.  If
something like this bothers you, then use a libc that does not include
kernel header files (which has been pointed out by the kernel authors
that they should not be doing.)  dietLibc [1] works for me quite well
and does not contain any kernel header files.

> If you (Greg, Alan) are confident that your interpretation of the GPL is 
> correct, then just marking the files as GPL should be sufficient. What 
> purpose is served by saying anything else?

As Alan stated, to reduce confusion as to the wishes of the copyright
holders of the file.  3 out of the 4 current holders agree to this
wording, and as the dissenting party, you are free to disagree and keep
that wording from the file (however a small note in it detailing this
disagreement might be a nice thing to do.)

thanks,

greg k-h

 [1] http://www.fefe.de/dietlibc/
