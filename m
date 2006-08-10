Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWHJKyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWHJKyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 06:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWHJKyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 06:54:40 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:25307 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161158AbWHJKyj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 06:54:39 -0400
Message-ID: <44DB106C.6090504@garzik.org>
Date: Thu, 10 Aug 2006 06:54:36 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [SATA] max-sect and sii-m15w branches merged
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just merged the max-sect and sii-m15w branches into the upstream branch.

This means that the following two changes are queued for 2.6.19:

* increase max sectors from 200 to 256 (for lba28)
* better mod15write support for sata_sil

