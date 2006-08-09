Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWHIUr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWHIUr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWHIUr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:47:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:28188 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751357AbWHIUr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:47:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fmwIDAzUmSbofsQtF6HD2LvGCxP22+OHdB0cNT9/U8DLRGLaMrR7LxBJr456ZG2rGfCx+oaL5GzUi02Pya5qnhjfXvzWozaYRz2TKARtZVDfVQzBEIllVXKkoQWJDOh+UT5CgrwndTkBBWoGkYf1/X522MffUwZjWtgrMlkm8hs=
Message-ID: <62b0912f0608091347u8b86d40q3679991e9e16526f@mail.gmail.com>
Date: Wed, 9 Aug 2006 22:47:00 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Duane Griffin" <duaneg@dghda.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
	 <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
	 <e9e943910608091317p37bdbd66t91bc1e16c3d9986a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duane Griffin wrote:
> > And what will e2fsck do to my dear filesystem if I let it have a go at it?
>
> To be safe, run it on an image of your filesystem first.

Yes, hmm, I don't have another terabyte handy, unfortunately.

> That is assuming you have enough spare space, of course.
> If not then you should at least run e2fsck with -n first to find out
> what it wants to do.

How close to 1-1 does "-n" relate to non-"-n" ?

For example, does e2fsck take into consideration the changes it would
have done itself in regular mode when it proceeds to the next problem
and/or phase of a -n operation?

If it doesn't, then that command is, well, totally useless.

So :-).  Does it take that into consideration?

> Personally, my risk tolerance would be closely correlated with
> the quality of my backups.

I hear you loud and clear...
Sigh ;-).

> "I never could learn to drink that blood and call it wine" - Bob Dylan

Hmm.  I like it.
