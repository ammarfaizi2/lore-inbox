Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUI1MrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUI1MrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 08:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUI1MrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 08:47:13 -0400
Received: from dialpool3-53.dial.tijd.com ([62.112.12.53]:18821 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S267678AbUI1MrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 08:47:10 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.9-rc2] ALSA nm256 driver causes system lockup
Date: Tue, 28 Sep 2004 14:47:17 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281447.17537.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

I'm trying to configure a laptop (Dell Latitude CXs) with 2.6.9-rc2. All runs 
well, except the ALSA nm256 driver for the Neomagic Audio chip. Loading this 
driver results in an immediate and complete system lockup....

I've tried appending "vaio_hack=1" on the kernel command line, but that didn't 
really do anything.

ALSA is compiled as modules.

Any pointers?

Thanks.
-- 
You're ugly and your mother dresses you funny.
