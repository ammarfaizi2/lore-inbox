Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTDRPyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 11:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbTDRPyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 11:54:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:26006 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263118AbTDRPyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 11:54:51 -0400
Date: Fri, 18 Apr 2003 08:59:33 -0700 (PDT)
Message-Id: <20030418.085933.131914868.davem@redhat.com>
To: don-linux@isis.cs3-inc.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: proposed optimization for network drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <16032.7069.454420.811252@isis.cs3-inc.com>
References: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
	<20030418.013640.28803567.davem@redhat.com>
	<16032.7069.454420.811252@isis.cs3-inc.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: don-linux@isis.cs3-inc.com (Don Cohen)
   Date: Fri, 18 Apr 2003 08:37:01 -0700

   For instance, why does every driver have to call
   eth_type_trans?  Could that be delayed for netif_rx ?

Silly example.  Ethernet specific routines do not belong in
device generic netif_rx().

