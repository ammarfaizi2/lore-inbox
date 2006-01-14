Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWANWuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWANWuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWANWuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:50:21 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:21896 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751334AbWANWuU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:50:20 -0500
Date: Sun, 15 Jan 2006 00:50:18 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] sh updates
Message-ID: <20060114225018.GB4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This includes some various updates for sh. Including a new clock and
timer API, DMA updates, overhauling some of the I/O routines to allow for
further board cleanup, as well as shuffling some code around for reuse on
some new CPU subtypes.

Pretty much all of the changes are isolated to arch/sh and include/asm-sh.
