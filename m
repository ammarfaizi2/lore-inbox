Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937286AbWLDTBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937286AbWLDTBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937288AbWLDTBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:01:31 -0500
Received: from [212.33.163.154] ([212.33.163.154]:33086 "EHLO
	localhost.localdomain" rhost-flags-FAIL-??-OK-FAIL) by vger.kernel.org
	with ESMTP id S937286AbWLDTBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:01:30 -0500
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: la la la la ... swappiness
Date: Mon, 4 Dec 2006 22:02:17 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612042202.17200.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a workaround try this:

echo 2 > /proc/sys/vm/overcommit_memory
echo 0 > /proc/sys/vm/overcommit_ratio

Hopefully someone can fix this intrinsic swap before drop behaviour.


Thanks!

--
Al

