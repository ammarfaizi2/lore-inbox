Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265157AbRFUTnb>; Thu, 21 Jun 2001 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265158AbRFUTnW>; Thu, 21 Jun 2001 15:43:22 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21128 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265157AbRFUTnL>;
	Thu, 21 Jun 2001 15:43:11 -0400
Date: Thu, 21 Jun 2001 21:42:37 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106211942.VAA373448.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: more gendisk stuff
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No comments on races, but there's obvious one on API: doing that on
> per-major basis is _wrong_.

Even though you do not define "that", most likely I agree.
Still, many intermediate steps are needed.
For a very large number of these steps the final API is irrelevant.

The project of this week is to remove all references to partitions
from all drivers.

Andries
