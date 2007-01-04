Return-Path: <linux-kernel-owner+w=401wt.eu-S1030251AbXADV7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbXADV7m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbXADV7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:59:42 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:47324 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030190AbXADV7l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:59:41 -0500
To: Petr Vandrovec <petr@vandrovec.name>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] Unbreak MSI on ATI devices
X-Message-Flag: Warning: May contain useful information
References: <20061221075540.GA21152@vana.vc.cvut.cz>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 04 Jan 2007 13:59:37 -0800
In-Reply-To: <20061221075540.GA21152@vana.vc.cvut.cz> (Petr Vandrovec's message of "Thu, 21 Dec 2006 08:55:40 +0100")
Message-ID: <ada4pr61mie.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jan 2007 21:59:39.0821 (UTC) FILETIME=[A1C71DD0:01C7304B]
Authentication-Results: sj-dkim-7; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim7002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So my question is - what is real reason for disabling INTX when in MSI mode?
 > According to PCI spec it should not be needed, and it hurts at least chips
 > listed below:
 > 
 > 00:13.0 0c03: 1002:4374 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
 > 00:13.1 0c03: 1002:4375 USB Controller: ATI Technologies Inc IXP SB400 USB Host Controller
 > 00:13.2 0c03: 1002:4373 USB Controller: ATI Technologies Inc IXP SB400 USB2 Host Controller 

heh... I'm not gloating or anything... but I am glad that some ASIC
designer was careless enough to prove me right when I said going
beyond what the PCI spec requires is dangerous.

 - R.
