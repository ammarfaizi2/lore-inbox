Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261334AbVCLKgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbVCLKgP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 05:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVCLKgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 05:36:14 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:27324 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S261334AbVCLKgM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 05:36:12 -0500
Date: Sat, 12 Mar 2005 02:36:10 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: chaffee@bmrc.berkeley.edu
cc: mc@cs.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CHECKER] sync doesn't flush everything out (msdos and vfat, 2.6.11)
Message-ID: <Pine.GSO.4.44.0503120230540.10944-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is yet another report from FiSC :)  This time FiSC complains that
sync on msdos and vfat doesn't flush everything out.  Crash after sync
still causes data loss.

Test cases and crashed disk images can be found at
http://fisc.stanford.edu/bug8    (msdos)
http://fisc.stanford.edu/bug11   (vfat)

Confirmations/clarifications are apprecitaed.

-Junfeng


