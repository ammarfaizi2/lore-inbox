Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbTBZUVZ>; Wed, 26 Feb 2003 15:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbTBZUVZ>; Wed, 26 Feb 2003 15:21:25 -0500
Received: from palrel10.hp.com ([156.153.255.245]:7633 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id <S268896AbTBZUVZ>;
	Wed, 26 Feb 2003 15:21:25 -0500
From: Scott Lee <scottlee@redhot.rose.hp.com>
Message-Id: <200302262031.MAA18505@redhot.rose.hp.com>
Subject: Re: [PATCH] ide write barriers
To: linux-kernel@vger.kernel.org
Date: Wed, 26 Feb 2003 12:31:36 -0800 (PST)
Cc: axboe@suse.de
X-Mailer: ELM [$Revision: 1.17.214.2 $]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The goal is to make the use of write
> back cache enabled ide drives safe with journalled file systems.

Does this mean that having write caching enabled is not safe if you are using ext3 on an IDE drive?  Should "hdparm -W 0 /dev/hda" be used for example.  (I see a 50% performance hit using "-W 0" when my box is under load.)  If this is the case, what is the root cause?  Do IDE drives reorder writes when they are cached?

Thank you in advance for any guidance.

Scott Lee
