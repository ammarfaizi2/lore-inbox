Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbRENQx1>; Mon, 14 May 2001 12:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262275AbRENQxR>; Mon, 14 May 2001 12:53:17 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21447 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262271AbRENQxK>;
	Mon, 14 May 2001 12:53:10 -0400
Date: Mon, 14 May 2001 18:53:05 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200105141653.SAA09595.aeb@vlet.cwi.nl>
To: R.E.Wolff@bitwizard.nl, alan@lxorguk.ukuu.org.uk
Subject: Re: Minor numbers
Cc: aqchen@us.ibm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> 20:12 is more common

>> Which is major, which is minor?

> 20bit major

That is not more common. Around us we see major:minor splits
8:24, 12:20, 14:18. If we want to use NFSv3 and communicate
with all these systems we would do wise to use 32:32.

[Reminds me of a discussion that ended unfinished.
Stage 1: "64 bits? Never in hell!"
Answer 1: These 64 bits do not make the kernel slow.
  Indeed, the kernel uses a 32-bit pointer.
Stage 2: "but I am on a holy crusade"
Answer 2: These bits are not about bloat but about the width of
  the communication channel between user space and filesystem.
Stage 3: <silence so far>
Wonder whether Linus still objects. Let me cc him.]

Andries
