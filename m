Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVCLAA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVCLAA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 19:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVCKX4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 18:56:43 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:19900 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261839AbVCKXxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 18:53:08 -0500
Date: Fri, 11 Mar 2005 17:52:58 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc32: Remove SPR short-hand defines
Message-ID: <Pine.LNX.4.61.0503111746300.9519@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Removed the Special purpose register (SPR) short-hand defines to help with 
name space pollution.  All SPRs are now referenced as SPRN_<foo>.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

(patch was above the normal size limit)

http://gate.crashing.org/~galak/spr-rework.20050311.l26.patch
