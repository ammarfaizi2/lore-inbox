Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbVAKXTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVAKXTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVAKXRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:17:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:1507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262899AbVAKXRA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:17:00 -0500
Date: Tue, 11 Jan 2005 15:16:56 -0800
From: Chris Wright <chrisw@osdl.org>
To: wli@holomorphy.com, colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: node_online_map patch kills x86_64
Message-ID: <20050111151656.A24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Backing out the x86_64 specific bits of the numnodes -> node_online_map
patch and the generic bits from wli, kills my machine at boot.

It hits the early_idt_handler and dies straight away.  What would help
to debug this thing?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
