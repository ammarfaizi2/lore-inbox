Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbTHAKYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 06:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHAKYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 06:24:22 -0400
Received: from wing.tritech.co.jp ([202.33.12.153]:40365 "HELO
	wing.tritech.co.jp") by vger.kernel.org with SMTP id S270620AbTHAKYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 06:24:21 -0400
Date: Fri, 01 Aug 2003 19:24:19 +0900 (JST)
Message-Id: <20030801.192419.68158364.ooyama@tritech.co.jp>
To: linux-kernel@vger.kernel.org
Subject: RAW or BLK in 2.4.21 
From: ooyama eiichi <ooyama@tritech.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I am developping a block device kernel module in 2.4 series.
And i want to make a distinction between raw I/O and block I/O,
in the request function i wrote for my module.
But i could not find the way.

my_request_fn(request_queue_t *q, int rw, struct buffer_head * bh)

Is it possible ?
I would be happy if someone give me a hint about this.

Regards.
