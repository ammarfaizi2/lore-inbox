Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280939AbRKTVeQ>; Tue, 20 Nov 2001 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVd4>; Tue, 20 Nov 2001 16:33:56 -0500
Received: from gte1-22.ce.ftel.net ([206.24.95.226]:28094 "EHLO spinics.net")
	by vger.kernel.org with ESMTP id <S280939AbRKTVdx>;
	Tue, 20 Nov 2001 16:33:53 -0500
Date: Tue, 20 Nov 2001 13:33:40 -0800
Message-Id: <200111202133.fAKLXeT23455@spinics.net>
From: ellis@ftel.net (Rick Ellis)
Subject: sk_buff alignments
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Dp83820 gigabit ethernet chip requires its buffers to be
on 64 bit boundaries.  Does this mean I have to copy the
packet?

