Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268144AbUIGT6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268144AbUIGT6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUIGT4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:56:24 -0400
Received: from the-village.bc.nu ([81.2.110.252]:45989 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268346AbUIGTvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:51:51 -0400
Subject: The Serial Layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094582980.9750.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 19:49:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone currently looking at fixing this before I start applying
extreme violence ? In particular to start trying to do something about
the races in TIOCSTI, line discipline setting, hangup v receive, drivers
abusing the API and calling ldisc.receive_buf direct ?

Alan

