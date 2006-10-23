Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751866AbWJWJza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbWJWJza (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751867AbWJWJza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:55:30 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:33411 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S1751866AbWJWJza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:55:30 -0400
Date: Mon, 23 Oct 2006 11:55:14 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: rtmutex's wait_lock in 2.6.18-rt7
Message-ID: <Pine.LNX.4.64.0610231150500.12557@frodo.shire>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I see that in 2.6.18-rt7 the rtmutex's wait_lock is sudden interrupt 
disabling. I don't see the need as no (hard) interrupt-handlers should be 
touching any mutex.

Esben

