Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVC3JrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVC3JrC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 04:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVC3JrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 04:47:02 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:24207 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261830AbVC3Jq7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 04:46:59 -0500
Date: Wed, 30 Mar 2005 11:46:34 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Friesen <cfriesen@nortel.com>
cc: Peter Chubb <peterc@gelato.unsw.edu.au>,
       krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
In-Reply-To: <4249F1B0.6050800@nortel.com>
Message-ID: <Pine.LNX.4.61.0503301146080.4164@yvahk01.tjqt.qr>
References: <424779F3.5000306@globaledgesoft.com> <4248E282.1000105@nortel.com>
 <16969.58762.180127.283274@wombat.chubb.wattle.id.au> <4249F1B0.6050800@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For ppc this only gives 32-bit values, which overflow every 129 seconds on my
> G5.  Depending on how long you're trying to time, this could be a problem.

Just take an extra measure to "record" overflows (2^32-1 => 0) and you're set.



Jan Engelhardt
-- 
No TOFU for me, please.
