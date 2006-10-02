Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWJBJuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWJBJuB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 05:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWJBJuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 05:50:01 -0400
Received: from natblert.rzone.de ([81.169.145.181]:18307 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S932131AbWJBJuA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 05:50:00 -0400
Date: Mon, 2 Oct 2006 11:49:59 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PARPORT_PC_SUPERIO 
Message-ID: <20061002094959.GA13986@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does aynone know if the hardware that is enabled with
CONFIG_PARPORT_PC_SUPERIO is available on PCI devices? The functions
detect_and_report_winbond() and detect_and_report_smsc() poke at random
legacy IO ports. I just wonder if they may also find the hardware if
they come from a PCI device.
If they are i386 only, the config option should probably be i386 (or
whatever) only.
