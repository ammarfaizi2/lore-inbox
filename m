Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbTF1Fto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 01:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTF1Fto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 01:49:44 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:11367 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264546AbTF1Ftn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 01:49:43 -0400
Date: Fri, 27 Jun 2003 23:04:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.73-mm2 drivers/net/pcmcia/nmclan_cs compile problem
Message-Id: <20030627230411.39e07e78.akpm@digeo.com>
In-Reply-To: <200306281318.42517.mflt1@micrologica.com.hk>
References: <200306281318.42517.mflt1@micrologica.com.hk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jun 2003 06:03:59.0189 (UTC) FILETIME=[10DE8850:01C33D3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank <mflt1@micrologica.com.hk> wrote:
>
> drivers/net/pcmcia/nmclan_cs.c: In function `nmclan_config':
>  drivers/net/pcmcia/nmclan_cs.c:714: parse error before `*'

--- 25/drivers/net/pcmcia/nmclan_cs.c~nmclan_cs-fix	2003-06-27 23:03:32.000000000 -0700
+++ 25-akpm/drivers/net/pcmcia/nmclan_cs.c	2003-06-27 23:03:47.000000000 -0700
@@ -710,7 +710,7 @@ while ((last_ret=CardServices(last_fn=(f
 static void nmclan_config(dev_link_t *link)
 {
   client_handle_t handle = link->handle;
-  struct net_device *dev = link->priv;;
+  struct net_device *dev = link->priv;
   mace_private *lp = dev->priv;
   tuple_t tuple;
   cisparse_t parse;

_

