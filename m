Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRKFKSf>; Tue, 6 Nov 2001 05:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278890AbRKFKS0>; Tue, 6 Nov 2001 05:18:26 -0500
Received: from 66-75-138-21.san.rr.com ([66.75.138.21]:4509 "EHLO
	homer.ka9q.net") by vger.kernel.org with ESMTP id <S278722AbRKFKSQ>;
	Tue, 6 Nov 2001 05:18:16 -0500
Date: Tue, 6 Nov 2001 02:18:11 -0800
Message-Id: <200111061018.fA6AIBV06382@homer.ka9q.net>
From: Phil Karn <karn@ka9q.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.14 is missing deactivate_page, needed by loop.o
Reply-to: karn@ka9q.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loopback block device driver module loop.o has an unresolved symbol,
deactivate_page. This function had been defined in mm/swap.c, but it
was removed in 2.4.14.

--Phil

