Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbUKNBVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUKNBVv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 20:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbUKNBVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 20:21:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:38876 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261226AbUKNBVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 20:21:48 -0500
Date: Sun, 14 Nov 2004 02:21:43 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] __devinit in parport_pc.c
Message-ID: <20041114012142.GA27453@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -uprN -X /linux/dontdiff a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
--- a/drivers/parport/parport_pc.c	2004-10-30 21:44:01.000000000 +0200
+++ b/drivers/parport/parport_pc.c	2004-11-14 00:53:02.000000000 +0100
@@ -2989,7 +2989,7 @@ static struct pnp_driver parport_pc_pnp_
 
 
 /* This is called by parport_pc_find_nonpci_ports (in asm/parport.h) */
-static int __init __attribute__((unused))
+static int __devinit __attribute__((unused))
 parport_pc_find_isa_ports (int autoirq, int autodma)
 {
 	int count = 0;
