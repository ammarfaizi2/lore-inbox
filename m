Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282880AbRLBOIz>; Sun, 2 Dec 2001 09:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282885AbRLBOIp>; Sun, 2 Dec 2001 09:08:45 -0500
Received: from relay03.cablecom.net ([62.2.33.103]:5661 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S282880AbRLBOI1>; Sun, 2 Dec 2001 09:08:27 -0500
Message-Id: <200112021408.fB2E81M21560@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Lord Latex <llx@swissonline.ch>
Reply-To: Lord Latex <llx@swissonline.ch>
To: linux-kernel@vger.kernel.org
Subject: max_sectors
Date: Sun, 2 Dec 2001 15:07:45 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

is there a limit other then max_sectors that limimits the
maximum size of a request for a block device? in my block
device driver i allow requests up to 512KB. but when
i do i/o from a user process don't profit from i/o's 
greater then 64KB.

