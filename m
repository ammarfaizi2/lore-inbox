Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269069AbUHYBIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269069AbUHYBIl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269075AbUHYBIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:08:41 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:3794 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S269069AbUHYBIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:08:39 -0400
Message-Id: <200408250108.i7P18bG00800@mail002.syd.optusnet.com.au>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: chakkerz_dev@optusnet.com.au
To: linux-kernel@vger.kernel.org
Cc: chakkerz@optusnet.com.au
Date: Wed, 25 Aug 2004 11:08:37 +1000
Subject: nforce2 / i8x0 sound breakage -> sys lockup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, just wanted to note that the sound in 2.6.7 and 2.6.8.1 is dead:

after compiling and installing etc the new kernels first thing i was seeing was 
occasional lockups in 2.6.7 and was blaming nvidia's taint. 2.6.8.1 saw far more 
lockups, however after investigating the issue of the nvidia drivers i found it wasn't the 
gfx system that was causing it, it was sound.

playing with mpg123 i got complaints of libao being broken, so i upgraded that, the i 
got pcm_hw something or other I/O errors.

it's a GA 7N400 Pro 2 Mobo, with nforce2 chipset though i believe it uses a realtech 
sound chip (not sure of the type). I found a couple of references to this being stuffed, 
and HP specific fixes (which don't help :) )

Distro is Slack 10.0

Any thoughts on a solution? please CC chakkerz@optusnet.com.au / reply all on this, 
so i get the message :)

thanks
  Christian Unger
