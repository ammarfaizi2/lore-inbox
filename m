Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUC2TCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263092AbUC2TCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:02:53 -0500
Received: from mail.solcon.nl ([212.45.33.11]:49869 "EHLO mail.solcon.nl")
	by vger.kernel.org with ESMTP id S263090AbUC2TCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:02:51 -0500
Subject: Re: [PATCH] ppc32: Fix sector_t definition with CONFIG_LBD
From: Michel Roelofs <huender.k@solcon.nl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1080586961.2587.8.camel@maan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Mar 2004 21:02:41 +0200
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.24.0.7; VDF 6.24.0.75
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> sector_t depends on CONFIG_LBD but include/config.h may not be there
> thus causing interesting breakage in some places... 
> Here's the fix for ppc32 (problem found by Roman Zippel, other archs
> need a similar fix).

This indeed solves the oops when mounting an HFS fs on my ppc32.


