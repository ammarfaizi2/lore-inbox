Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264038AbTE1MUa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbTE1MUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:20:30 -0400
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:9112 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id S264038AbTE1MU3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:20:29 -0400
Date: Wed, 28 May 2003 14:33:25 +0200 (CEST)
From: fcorneli@elis.ugent.be
To: linux-kernel@vger.kernel.org
Subject: 2.5.70: mmu_cr4_features
Message-ID: <Pine.LNX.4.44.0305281427390.20674-100000@tom.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I compile i810 and i830 as a module depmod starts whining about the 
unknown symbol mmu_cr4_features, hence me whining.
Putting
	EXPORT_SYMBOL(mmu_cr4_features);
somewhere would be nice.
BTW: before a .xx release, is anyone checking the tree for 
compilation/deployment?

Frank.

