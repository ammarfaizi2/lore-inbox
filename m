Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265285AbTASCCc>; Sat, 18 Jan 2003 21:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265320AbTASCCc>; Sat, 18 Jan 2003 21:02:32 -0500
Received: from hera.cwi.nl ([192.16.191.8]:50892 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S265285AbTASCCb>;
	Sat, 18 Jan 2003 21:02:31 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 19 Jan 2003 03:11:32 +0100 (MET)
Message-Id: <UTC200301190211.h0J2BWb01426.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: oops in module code
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably well-known, I haven't read l-k yet.
Compiled and booted vanilla 2.5.59.
Insmod usb-storage. Oops.
(load_module -> simplify_symbols -> resolve_symbol -> __find_symbol)

Andries
