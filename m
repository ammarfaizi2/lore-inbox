Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTFDDev (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 23:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbTFDDeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 23:34:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:31444 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262714AbTFDDet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 23:34:49 -0400
Date: Tue, 03 Jun 2003 20:46:12 -0700 (PDT)
Message-Id: <20030603.204612.48501825.davem@redhat.com>
To: shemminger@osdl.org
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       linux-net@vger.kernel.org
Subject: Re: Regarding SET_NETDEV_DEV
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EDD6B51.9070909@osdl.org>
References: <20030603175921.GE2079@gtf.org>
	<20030603.200944.78736971.davem@redhat.com>
	<3EDD6B51.9070909@osdl.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: Tue, 03 Jun 2003 20:45:21 -0700

   There are enough PCI network devices, that something like 
   alloc_pci_etherdev might
   be a good future idea.
   
What is sos special about PCI? :-)

In this light, alloc_device_etherdev() seems much more appropriate.

But we can play this game AD_INFINITUM, for each and every paramter
that is common across a class of ethernet devices.  At what point
do you stop? :-)
