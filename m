Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281000AbRKTVg4>; Tue, 20 Nov 2001 16:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280998AbRKTVgq>; Tue, 20 Nov 2001 16:36:46 -0500
Received: from gte1-22.ce.ftel.net ([206.24.95.226]:28862 "EHLO spinics.net")
	by vger.kernel.org with ESMTP id <S281016AbRKTVgd>;
	Tue, 20 Nov 2001 16:36:33 -0500
Date: Tue, 20 Nov 2001 13:34:55 -0800
Message-Id: <200111202134.fAKLYtT23465@spinics.net>
From: ellis@ftel.net (Rick Ellis)
Subject: sk_buff alignments
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Dp83820 gigabit ethernet chip requires its buffers to be
on 64 bit boundaries.  Does this mean I have to copy the
packet?
