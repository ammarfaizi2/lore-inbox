Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTJ3Nox (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 08:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTJ3Nox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 08:44:53 -0500
Received: from karpfen.mathe.tu-freiberg.de ([139.20.24.195]:42114 "EHLO
	karpfen.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id S262491AbTJ3Nov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 08:44:51 -0500
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [2.6.0-test9] alsa intel8x0: scattered sound playback
Date: Thu, 30 Oct 2003 14:44:24 +0100
User-Agent: KMail/1.5.3
References: <slrnbpvkdj.845.christian.kapeller@campus14.panorama.sth.ac.at>
In-Reply-To: <slrnbpvkdj.845.christian.kapeller@campus14.panorama.sth.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301444.24606.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mittwoch, 29. Oktober 2003 15:41 wrote Christian Kapeller:

> Since i'm running the 2.6.0 (2.6.0-test9-bk1 currently) kernel i
> encounter problems with alsa sound playback.
>

>
> The sound is very scatterd and parts of the playback are repeated
> sometims. Stopping the playback and starting it again, fixes it -
> somtimes, and if then only for a couple of seconds.

I can confirm this partly. 
Yesterday, playwave gave a scattered sound (skips and many repeated
sounds). Today playwave works. I could not get xmms working
(neither yesterday nor today). This is 2.6.0-test9.

xmms was fine in test5, running at half speed in test6 and test7, 
fine in test8, broken in test9.


But I did not get the following messages:

> /var/log/kern.log shows the following error messages:
>
> ----
> Oct 28 18:18:08 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155:
> Unexpected hw_pointer value (stream = 0, delta: -1314, max jitter =
> 8192): wrong interrupt acknowledge? Oct 28 18:18:08 xxxxxxxx kernel:
> ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream =
> 0, delta: -1024, max jitter = 8192): wrong interrupt acknowledge? Oct
> 28 18:19:29 xxxxxxxx kernel: ALSA sound/core/pcm_lib.c:155: Unexpected
> hw_pointer value (stream = 0, delta: -1084, max jitter = 8192): wrong
> interrupt acknowledge? Oct 28 18:19:29 xxxxxxxx kernel: ALSA
> sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0,
> delta: -1024, max jitter = 8192): wrong interrupt acknowledge? --

Michael
