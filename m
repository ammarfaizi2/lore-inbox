Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269584AbUIRSHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269584AbUIRSHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 14:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269606AbUIRSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 14:07:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39087 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S269584AbUIRSHU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 14:07:20 -0400
Date: Sat, 18 Sep 2004 20:07:18 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200409181807.i8II7IK06013.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: hackbench?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On http://developer.osdl.org/craiger/hackbench one finds hackbench.c
and the result that 2.6 is much better than 2.4 where scheduling is
concerned.

I was shown results that go in the other direction, so just tried
on a machine here.

50 processes
2.4.26:   24 sec
2.6.0t11: 72 sec
2.6.8.1: 120 sec

20 processes
2.4.26:    8.6 sec
2.6.0t11: 29   sec
2.6.8.1:  30   sec

This was on a 256 MB 400 MHz Pentium II.

Andries
