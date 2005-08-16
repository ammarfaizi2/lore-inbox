Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932739AbVHPVdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbVHPVdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbVHPVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 17:33:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932736AbVHPVdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 17:33:47 -0400
Date: Tue, 16 Aug 2005 14:34:16 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: netdev@vger.kernel.org, lartc@mailman.ds9a.nl
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] iproute2 util update
Message-ID: <20050816143416.61c10513@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/dev/iproute2/download/iproute2-050816.tar.gz

Update to iproute2 to include:
	* Limit ip neigh flush to 10 rounds
	* tc ematch support (thomas)
	* build cleanups (thomas, et al)
	* Fix for options process with ipt (jamal)
	* Fix array overflow in paretonormal distribution build
	* Update include files to 2.6.13
	* Decnet doc update (Steven Whithouse)

Note: the ematch support won't build on really old versions of bison (1.28),
      but the kernel on those systems wouldn't support it anyway.
