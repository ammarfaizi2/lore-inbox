Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbVCXGjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVCXGjg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 01:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbVCXGjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 01:39:36 -0500
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:6800 "HELO
	smtp104.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S263055AbVCXGje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 01:39:34 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Greg K-H <greg@kroah.com>
Subject: [2.6.11.5][BUILD] i2c.h breakage in 2.6.12-rc1 + -mm only
Date: Thu, 24 Mar 2005 01:39:29 -0500
User-Agent: KMail/1.7.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <11099685952869@kroah.com>
In-Reply-To: <11099685952869@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240139.29897.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/i2c.h:58: error: array type has incomplete element type
include/linux/i2c.h:197: error: array type has incomplete element type
/usr/local/src/sources/r300_driver/drm/linux-core/radeon_drv.h:274: confused by earlier errors, bailing out

I see further back you fed the gcc 4.0 compile fixes to akpm for this, can this be merged in to 2.6.11.6?

Thanks, 

Shawn.
