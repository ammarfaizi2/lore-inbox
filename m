Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVL0Xp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVL0Xp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 18:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVL0Xp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 18:45:26 -0500
Received: from mx.pathscale.com ([64.160.42.68]:44238 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932400AbVL0Xp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 18:45:26 -0500
Content-Type: multipart/mixed; boundary="===============1945944692=="
MIME-Version: 1.0
Subject: [PATCH 0 of 3] Add memcpy_toio32, a 32-bit MMIO copy routine
Message-Id: <patchbomb.1135726914@eng-12.pathscale.com>
Date: Tue, 27 Dec 2005 15:41:54 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org
Cc: mpm@selenic.com, akpm@osdl.org, hch@infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============1945944692==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Following some discussion with Matt, Andrew and Chris, here is a recast
of the 32-bit MMIO patch I posted the other day.  The routine is now
named memcpy_toio32, and is provided in generic and x86_64-optimised
forms.

I haven't added a memcpy_fromio32, or routines for other access sizes,
because our hardware doesn't need them.  If someone wants them for
reasons of symmetry, I can introduce them.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

--===============1945944692==--
