Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271384AbTGQKYh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271392AbTGQKYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:24:37 -0400
Received: from d40.sstar.com ([209.205.179.40]:41725 "EHLO scud.asjohnson.com")
	by vger.kernel.org with ESMTP id S271384AbTGQKYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:24:37 -0400
From: "Andrew S. Johnson" <andy@asjohnson.com>
To: linux-kernel@vger.kernel.org
Subject: DRM, radeon, and X 4.3
Date: Thu, 17 Jul 2003 05:39:25 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307170539.25702.andy@asjohnson.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I start X but it says DRM is disabled, even though the
radeon and agpgart modules are loaded.  Here is the dmesg tail:

Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized radeon 1.9.0 20020828 on minor 0
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 1929 using kernel context 0

There is something X doesn't like.  How do I fix this?

Andy Johnson

