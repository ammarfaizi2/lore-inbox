Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967457AbWK2XiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967457AbWK2XiA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967678AbWK2XiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:38:00 -0500
Received: from [198.186.3.68] ([198.186.3.68]:64167 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S967457AbWK2Xh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:37:58 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 2] Add memcpy_cachebypass,
	a memcpy that doesn't cache reads
Message-Id: <patchbomb.1164843307@eng-12.pathscale.com>
Date: Wed, 29 Nov 2006 15:35:07 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akmp@osdl.org
Cc: rdreier@cisco.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add a memcpy that doesn't cache reads, and use it in the
ipath driver's OpenIB receive path.

This version incorporates a few changes asked for last time around by DaveM.

	<b
