Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJBFpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJBFpq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 01:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267294AbUJBFpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 01:45:46 -0400
Received: from gw.anda.ru ([212.57.164.72]:20740 "EHLO mail.ward.six")
	by vger.kernel.org with ESMTP id S267312AbUJBFol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 01:44:41 -0400
Date: Sat, 2 Oct 2004 11:44:34 +0600
From: Denis Zaitsev <zzz@anda.ru>
To: linux-kernel@vger.kernel.org
Subject: [2.6.8.1/x86] Kernel doesn't see the serial port of an ISA modem
Message-ID: <20041002114434.A880@natasha.ward.six>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ISAPNP scans PnP cards and finds the ISA modem.  And then 8250
reports about the only two serial ports found, which live in the
motherboard.  And there is no the modem's ttyS2, no its IRQ.  Under
2.4.x kernels all the things work fine.  So, where am I wrong?
