Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266025AbUFWGXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266025AbUFWGXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 02:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUFWGXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 02:23:49 -0400
Received: from mproxy.gmail.com ([216.239.56.249]:21747 "HELO mproxy.gmail.com")
	by vger.kernel.org with SMTP id S266025AbUFWGXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 02:23:47 -0400
Message-ID: <9dda3492040622232337451cbb@mail.gmail.com>
Date: Wed, 23 Jun 2004 02:23:43 -0400
From: Diffie <diffie@gmail.com>
To: "kernel@kolivas.org" <kernel@kolivas.org>
Subject: Re: [PATCH] Staircase 7.1 for 2.6.7-mm1
Cc: Panagiotis Papadakos <papadako@csd.uoc.gr>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1087957407.40d8e99fb1398@vds.kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9dda34920406222056500f67d3@mail.gmail.com> <1087957407.40d8e99fb1398@vds.kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con,

Thanks for pointing this out. I have just patched from s7.1 to s7.3
and did notice much better responses under the game...yet music still
skips when moving the mouse very very fast.

Also when playing bmp or xmms and trying to turn on caps lock on USB
kbd there's this pause of a second...but that could be related to the
keyboard itself. I thought i would mention this though.

Regards,

Paul

On Wed, 23 Jun 2004 12:23:27 +1000, kernel@kolivas.org
<kernel@kolivas.org> wrote:
> 
> Quoting Diffie <diffie@gmail.com>:
> 
> > I have tried this staircase patch on 2.6.7-mm1 kernel under NForce2
> > based system and when playing games the sound stops and skips every
> > second and moving mouse at the same time makes the response very
> > slow.The game is Unreal engine based.
> 
> Most hardware got better for this problem with s7.1. There is a new release that
> addressed a few bugs only just announced on lkml (staircase 7.3) which seemed
> to fix this problem on machines tested so far. This should address these
> issues.
> 
> Note that at very high loads mainline will be more responsive, but it does this
> to the detriment of fairness which I decided was not worth pursuing in
> staircase. The machine should will be usable at these very high loads - which
> is important when a box goes out of control - but it will not be as smooth as
> mainline.
> 
> Thanks for feedback.
> 
> Cheers,
> Con
>
