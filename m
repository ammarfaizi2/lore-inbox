Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTJNUbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 16:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJNUbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 16:31:12 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:8832 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262610AbTJNUbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 16:31:12 -0400
Date: Tue, 14 Oct 2003 22:31:09 +0200
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: Vortex full-duplex doesn't work?
Message-ID: <20031014223109.A7167@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have collected from tidbits of information that
ether=0,0,0x201,0,eth0 should set my 3c900 card to full duplex AUI.

I have tried this, then ifconfig eth0 up and then
vortex-diag -vv and it still reports MAC Settings: half-duplex

When I rewrite all occurences of full_duplex in 3c59x.c for hard-coded
"1", then I get MAC Settings: full-duplex

How do I set up this driver to force full-duplex AUI for 3c900 network
card without using modules and without patching 3c59x.c?

Cl<
