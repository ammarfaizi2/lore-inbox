Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269703AbUINUX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269703AbUINUX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 16:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbUINUSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 16:18:21 -0400
Received: from gw.anda.ru ([212.57.164.72]:61190 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S269734AbUINUO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 16:14:27 -0400
Date: Wed, 15 Sep 2004 02:14:18 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1/x86] The kernel is _always_ compiled with -msoft-float
Message-ID: <20040915021418.A1621@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why this kernel is always compiled with the FP emulation for x86?
This is the line from the beginning of arch/i386/Makefile:

CFLAGS += -pipe -msoft-float

And it's hardcoded, it does not depend on CONFIG_MATH_EMULATION.  So,
is this just a typo or not?
