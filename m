Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbUCOFbM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUCOFbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:31:12 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:51073 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262265AbUCOFbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:31:07 -0500
Date: Mon, 15 Mar 2004 00:27:31 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315002731.GG5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com> <20040315001519.GC5972@neo.rr.com> <20040315002146.GD5972@neo.rr.com> <20040315002357.GE5972@neo.rr.com> <20040315002607.GF5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315002607.GF5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ISAPNP] Remove Experimental Status

isapnp has been stable for a while in the new pnp layer.  This patch
unmarks it from experimental.

--- b/drivers/pnp/isapnp/Kconfig	2004-03-12 22:25:17.000000000 +0000
+++ a/drivers/pnp/isapnp/Kconfig	2004-03-14 23:32:23.000000000 +0000
@@ -2,8 +2,8 @@
 # ISA Plug and Play configuration
 #
 config ISAPNP
-	bool "ISA Plug and Play support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL
+	bool "ISA Plug and Play support"
+	depends on PNP
 	help
 	  Say Y here if you would like support for ISA Plug and Play devices.
 	  Some information is in <file:Documentation/isapnp.txt>.
