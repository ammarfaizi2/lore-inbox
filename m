Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTG1KZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 06:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264448AbTG1KZx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 06:25:53 -0400
Received: from foo.gazonk.org ([213.212.13.120]:60586 "HELO gazonk.org")
	by vger.kernel.org with SMTP id S264186AbTG1KZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 06:25:53 -0400
Date: Mon, 28 Jul 2003 12:41:06 +0200 (CEST)
From: Jonas Bofjall <j-lnxk@gazonk.org>
X-X-Sender: jonas@gazonk.org
To: linux-kernel@vger.kernel.org
Subject: FYI: TCQ ReiserFS Corruption on 2.6.0-test1-mm2
Message-ID: <Pine.LNX.4.51.0307281231590.29434@gazonk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use an IBM Deskstar 180GB IDE disk and tried out TCQ on 2.6.0-test1-mm2.
I have a VIA IDE interface on my A7V8X motherboard. This corrupted my
ReiserFS file system, just by running the same reiserfsck utility that
works well without TCQ. So at least on this disk/controller, IDE-TCQ
probably doesn't work well.
