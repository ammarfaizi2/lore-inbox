Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284905AbRLRUGN>; Tue, 18 Dec 2001 15:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284860AbRLRUF4>; Tue, 18 Dec 2001 15:05:56 -0500
Received: from vzn1-22.ce.ftel.net ([206.24.95.226]:48273 "EHLO spinics.net")
	by vger.kernel.org with ESMTP id <S284812AbRLRUFv>;
	Tue, 18 Dec 2001 15:05:51 -0500
From: ellis@spinics.net
Message-Id: <200112182006.fBIK6Qh11757@spinics.net>
Subject: Block device size limit
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Dec 2001 12:06:26 -0800 (PST)
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like a block device only has a 32 bit field to hold
the sector number.  Does this limit a filesystem to 2^32
sectors?

