Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbTLJQph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 11:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbTLJQph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 11:45:37 -0500
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:3248 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S263636AbTLJQph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 11:45:37 -0500
Subject: Update for IBM Thinkpad X31 and T40 users wishing to use miniPCI
	wifi cards
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Cc: durey@EmperorLinux.com
Content-Type: text/plain
Message-Id: <1071074736.16162.12.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 10 Dec 2003 08:45:36 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IBM has a newish Atheros-based 802.11a/b/g card, model number 31P9701,
which works with the Thinkpad X31.  I received mine last night and got
the infamous error 1802 (card not authorized).

I unplugged the miniPCI card and updated the X31's BIOS to revision
2.04, version 1QET66WW, dated 2003/12/02.  (I believe you must still
have Windows available to do this.)  The system now boots happily, and
the madwifi driver drives the card OK for me under both 2.4 and 2.6.

I assume that the PCI whitelist of infamy is still in place in the
latest BIOS, but at least it now supports a modern wifi card model.

	<b

