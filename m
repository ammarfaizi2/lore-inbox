Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUGYQRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUGYQRD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 12:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264192AbUGYQRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 12:17:03 -0400
Received: from [61.49.234.179] ([61.49.234.179]:12790 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264183AbUGYQRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 12:17:02 -0400
Date: Mon, 26 Jul 2004 00:13:18 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200407260713.i6Q7DI109481@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	It has been a while since I looked, but I vaguely recall
that cryptoloop on a plain file involves one less data copy for
reads than regular loop + dm-crypt.  This may be relevant for
people who want to play their encrypted DVD collection,
