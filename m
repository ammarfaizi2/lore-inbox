Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269631AbUICMVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269631AbUICMVI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269661AbUICMUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:20:39 -0400
Received: from the-village.bc.nu ([81.2.110.252]:26003 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269663AbUICMQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:16:15 -0400
Subject: Re: md RAID over SATA performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <1094169937l.17931l.0l@werewolf.able.es>
References: <1094169937l.17931l.0l@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094210023.7533.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 12:13:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 01:05, J.A. Magallon wrote:
> Problem is that i get really poor performance. A single drive gives about
> 57 Mb/s, and a raid1 with two just gives about 64 Mb/s (measured with
> hdparm -tT). With the six drives:

Looks about right. Whats your total PCI bus bandwidth, whats your VIA
V-Link bandwidth between the bridges ?


