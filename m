Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030437AbVKIAMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030437AbVKIAMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbVKIAMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:12:07 -0500
Received: from hera.kernel.org ([140.211.167.34]:62128 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030435AbVKIAMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:12:06 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH 1/7] PCI Error Recovery: header file patch
Date: Tue, 8 Nov 2005 16:11:58 -0800
Organization: OSDL
Message-ID: <20051108161158.51ef0d34@dxpl.pdx.osdl.net>
References: <20051108234911.GC19593@austin.ibm.com>
	<20051108235357.GD19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1131495119 31860 10.8.0.74 (9 Nov 2005 00:11:59 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 9 Nov 2005 00:11:59 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  
> +/** The pci_channel state describes connectivity between the CPU and
> + *  the pci device.  If some PCI bus between here and the pci device
> + *  has crashed or locked up, this info is reflected here.
> + */
> +typedef int __bitwise pci_channel_state_t;

Bit operations should be on unsigned not signed value.


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
