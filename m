Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280482AbRJaUdk>; Wed, 31 Oct 2001 15:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280485AbRJaUda>; Wed, 31 Oct 2001 15:33:30 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:39686 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S280482AbRJaUdT>; Wed, 31 Oct 2001 15:33:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Robert Love <rml@tech9.net>
Subject: Re: 2.4.14-pre6 + preempt dri lockup
Date: Wed, 31 Oct 2001 15:33:54 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011031152822Z280263-17408+8294@vger.kernel.org> <1004543705.1209.23.camel@phantasy>
In-Reply-To: <1004543705.1209.23.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011031203328Z280482-17409+6983@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 October 2001 10:55, Robert Love wrote:
> On Wed, 2001-10-31 at 10:28, safemode wrote:
> > Using 2.4.14-pre6 and Love's preempt patch, i recompiled my X's matrox
> > drm driver and loaded it.  All seemed well and good and i started X and
> > it locked up.  I had to reboot.  Upon rebooting I started X without
> > loading the drm module and disabling DRI and it loaded fine.  Tis not
> > good.   The drm module worked in every kernel prior to this one with and
> > without the preempt patch. I couldn't get an error message or anything
> > but i did hear my monitor resync, it just never displayed any kind of
> > image.  The entire system was unresponsive.
>
> Did you try it in 2.4.14-pre6 w/o preempt patch?
>
> Are you using the new non-atomic preempt patch (released last night for
> pre5)?  If so, can you try an old version on pre6?  Apply the pre2
> version to pre6 and see if it repeats...
>
> 	Robert Love

I tried it with 2.4.13 without the preempt patch and it worked ...i have not 
tried it without the preempt patch for 14, but since i'm not using the drm 
that comes with it.  The only thing that i think could be it is the new 
preempt patch.  I'm using the latest one you released for pre5.    Where is 
the 2.4.14-pre2 preempt patch?  all i see is pre5.   
