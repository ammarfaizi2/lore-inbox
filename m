Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUIKKZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUIKKZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 06:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUIKKZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 06:25:10 -0400
Received: from home.regit.org ([82.226.29.74]:11268 "EHLO home.regit.org")
	by vger.kernel.org with ESMTP id S268079AbUIKKZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 06:25:06 -0400
Subject: 2.6.9-rc1-mm4 : typo in include/linux/hardirq.h ?
From: Eric Leblond <eric@inl.fr>
Reply-To: regit@inl.fr
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: INL
Message-Id: <1094898290.4533.5.camel@porky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 11 Sep 2004 12:24:51 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: (----) -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On my i386 computer, at line 5 of include/linux/hardirq.h we can read :
#ifdef CONFIG_PREEPT
It seems it should be
#ifdef CONFIG_PREEMPT

With this change, compilation of external driver like ndiswrapper works
again.

Please CC me as I've not subscribed to the list.

BR,
-- 
Eric Leblond <eric@inl.fr>
INL

