Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279987AbRJ3PiD>; Tue, 30 Oct 2001 10:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279986AbRJ3Phx>; Tue, 30 Oct 2001 10:37:53 -0500
Received: from ssh-yyz.somanetworks.com ([216.126.67.45]:16672 "EHLO
	hydra.wireless-sys.com") by vger.kernel.org with ESMTP
	id <S279974AbRJ3Phr>; Tue, 30 Oct 2001 10:37:47 -0500
Date: Tue, 30 Oct 2001 10:38:22 -0500 (EST)
From: Scott Murray <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Jerome AUGE <auge@irit.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: opl3sa2 sound driver and mixers
In-Reply-To: <3BDE648E.135B39B8@irit.fr>
Message-ID: <Pine.LNX.4.33.0110301027520.20844-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Jerome AUGE wrote:

> Scott Murray wrote:
> > I've found myself too busy at work over the last while to really look into
> > any issues with this driver.  Anyone keen on taking over as maintainer?
>
> Some times ago I wanted to change the mixer part and get back to the
> "original" one, with a single mixer ... but as it was intentional, I
> left it like this.
>
> However I think it would be a good thing to present, to the user, a
> single mixer. You have 1 or more soundcards and each soundcard have a
> single mixer that control all the volume available with this card, no ?

I gave up on the idea because it seemed dumb to me to basically duplicate
the MSS mixer handling that's already implemented in ad1848.c, but feel
free to change it.  The mixer code from opl3sa2.c in the 2.2 kernels is
probably a good place to start.  Remember that you have to worry about
extra mixer channels on the SA3 versus the SA2.

> If Alan has not yet released a patch that changes this ... I could try
> to put all the controls back together ... and it will be the occasion to
> learn a little bit more of that "mighty and scaring kernel" :)

Give it a shot.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

