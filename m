Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274863AbTHPQRl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 12:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274866AbTHPQRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 12:17:41 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:15877 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S274863AbTHPQRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 12:17:40 -0400
Subject: O16.2int scheduler interactivity improvements
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Con Kolivas <kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1061050658.891.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 16 Aug 2003 18:17:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all!

I've been testing 2.6.0-test3-mm2 plus Con scheduler patches up to
O16.2int. I must say I feel it keeps improving. For my workloads
(usually interactive X applications and sound) O16.2int makes X feels
very smooth, even under heavy load (while true; do a=2; done).

I recommend everyone out there who is (somewhat) idle to give O16.2int a
spin. The more people testing this, the more likely we are able to get a
robust and fair scheduler. Sometimes, we feel the scheduler just doesn't
behave as we would like (and I've felt that way many times), but that's
no reason to give up. Please, test the latest OXXint patches and keep
your reports coming :-) We know we can do it better...

Thanks!

