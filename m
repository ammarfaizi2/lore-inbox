Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280736AbRKSVi2>; Mon, 19 Nov 2001 16:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280733AbRKSViJ>; Mon, 19 Nov 2001 16:38:09 -0500
Received: from mail.integrix.com ([207.178.218.205]:31172 "EHLO
	mail.integrix.com") by vger.kernel.org with ESMTP
	id <S280728AbRKSVh5>; Mon, 19 Nov 2001 16:37:57 -0500
Date: Mon, 19 Nov 2001 13:35:08 -0800 (PST)
Message-Id: <200111192135.fAJLZ7S02982@mail.integrix.com>
From: ellis@ftel.net (Rick Ellis)
Subject: sk_buff alignments
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Dp83820 gigabit ethernet chip requires its buffers to be
on 64 bit boundaries.  Does this mean I have to copy the
packet?

