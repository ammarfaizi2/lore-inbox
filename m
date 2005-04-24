Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262291AbVDXI62@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262291AbVDXI62 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 04:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbVDXI62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 04:58:28 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56960 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262291AbVDXI6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 04:58:25 -0400
Subject: Re: [2.6 patch] unexport insert_resource
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050423164411.51d77bf1.akpm@osdl.org>
References: <20050415151043.GJ5456@stusta.de>
	 <20050423164411.51d77bf1.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 10:58:21 +0200
Message-Id: <1114333102.6284.22.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or we just leave it as-is.  It depends whether insert_resource is a
> sensible part of the resource management API (I think it is).  If so,
> then we should just leave it exported, whether or not any in-kernel moduels
> happen to be using it at this point in time.

well it's sensible for platform code to announce resources sure. Drivers
generally only consume resources though and don't introduce them...


