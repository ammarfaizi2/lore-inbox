Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUCKV2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUCKV2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:28:51 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:2053 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261718AbUCKV2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:28:48 -0500
Subject: 2.6.4-mm1: 3c59x-xcvr-xif breaks 3CCFE575CT
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jgarzik@pobox.com, Kernel Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1079040485.856.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 11 Mar 2004 22:28:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.4-mm1 has turned to be a tricky kernel...: it breaks the 3c9x
transceiver making my 3CCFE575CT CardBus NIC unable to process any
incoming network frames, that is, no network communication takes place.

Reverting 3c59x-xcvr-fix.patch fixes the problem for me.

