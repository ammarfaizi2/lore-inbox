Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUCXNHW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 08:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUCXNHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 08:07:22 -0500
Received: from aun.it.uu.se ([130.238.12.36]:6273 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263335AbUCXNHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 08:07:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16481.34778.399231.603762@alkaid.it.uu.se>
Date: Wed, 24 Mar 2004 14:06:34 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, claus@momo.math.rwth-aachen.de,
       greg@kroah.com
Subject: Re: [PATCH 2.6 RFT] add class support to floppy tape driver zftape-init.c
In-Reply-To: <58110000.1079739485@w-hlinder.beaverton.ibm.com>
References: <58110000.1079739485@w-hlinder.beaverton.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder writes:
 > Here is a patch to add class support to zftape-init.c:
 > 
 > MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
 >                    "VFS interface for the Linux floppy tape driver. "
 >                    "Support for QIC-113 compatible volume table "
 >                    "and builtin compression (lzrw3 algorithm)");
 > 
 > I have verified it compiles but do not have the hardware to test it.
 > If someone who does could test it please do.

Tested in a monolithic 2.6.5-rc2 kernel. No observable breakage.

All it does is add some dev nodes in sysfs. How useful is that?

/Mikael
