Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276736AbRJKTj5>; Thu, 11 Oct 2001 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276764AbRJKTjs>; Thu, 11 Oct 2001 15:39:48 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:18695 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S276736AbRJKTjh>; Thu, 11 Oct 2001 15:39:37 -0400
Message-Id: <200110111940.f9BJe8Y97938@aslan.scsiguy.com>
To: linux-kernel@vger.kernel.org
Subject: Unconditional include of <linux/module.h> in aic7xxx driver
Date: Thu, 11 Oct 2001 13:40:08 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can anyone comment on why the include of <linux/module.h> is now
unconditional in the aic7xxx driver?  Assuming MODULE_LICENSE is
properly qualified by an #ifdef MODULE, the driver appears to compile
and function correctly without this include.  Are MODULE attributes
(MODULE_VERSION/AUTHOR/DESCRIPTION/etc.) now supposed to be included in
static configurations?

Thanks,
Justin
