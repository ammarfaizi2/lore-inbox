Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbUKOKmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUKOKmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 05:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbUKOKmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 05:42:37 -0500
Received: from mail.gmx.de ([213.165.64.20]:31670 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261469AbUKOKmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 05:42:35 -0500
From: Stephan Menzel <stephan42@chinguarime.net>
Organization: Chinguarime
To: linux-kernel@vger.kernel.org
Subject: Re: [FS] New monitor framework in 2.6.10?
Date: Mon, 15 Nov 2004 11:42:33 +0100
User-Agent: KMail/1.7.1
References: <200411151113.06386.stephan42@chinguarime.net> <Pine.LNX.4.53.0411151121240.6893@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411151121240.6893@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411151142.33640.stephan42@chinguarime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. November 2004 11:23 schrieb Jan Engelhardt:
> > will be exactly for this kind of purpose. Some kind of monitor frameworks
> > that can generate events for all sorts of things. Sorry, I don't know any
> > more about it.
>
> Wasnot it called System Call Auditing and/or Filesystem hooks?

Well, that's what I'd like to know.
System Call Auditing just yielded a few google results but it doesn't seem to 
me like a well documented feature. More like people asking for it.

> One or the other was present in SUSE's 2.4.20/.21 kernels and one is in
> 2.6.x -- and from what I have seen, they're just hooks, i.e.
>
> if(hook != NULL) { hook(fd, buf, size); }
>
> That's the most efficient thing you can have (in a function). It's only a
> question whether it is in the right function, then.

Indeed.
And just that made me hope there is something like an auditing or monitoring 
framework just like for instance a accessible struct with several function 
pointers where one could insert funtions to be processed whenever event x 
occurs. This kind of thing yould be maintained by the kernel developers who 
could put the hook just in the right place and the 'user' (which would be me 
in that case) could be sure that his function would be called in the right 
time and from the right place.
That would be nice.

Greetings...

Stephan
