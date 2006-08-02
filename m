Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWHBMEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWHBMEY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 08:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHBMEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 08:04:24 -0400
Received: from lx-ltd.ru ([85.113.143.174]:33513 "EHLO iserver.lx.intercon.ru")
	by vger.kernel.org with ESMTP id S1750786AbWHBMEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 08:04:24 -0400
To: linux-kernel@vger.kernel.org
Subject: OHCI and SKIP bit
From: Sergej Pupykin <ps@lx-ltd.ru>
Date: 02 Aug 2006 16:04:22 +0400
Message-ID: <m3irlbibsp.fsf@lx-ltd.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, All!

According to ohci spec (4.2.1, page 16) K (skip) bit is 12th.

But in both (2.4 and 2.6) kernels I see

#define OHCI_ED_SKIP    (1 << 14)

Please advise.

