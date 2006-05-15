Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbWEORHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWEORHK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWEORHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:07:10 -0400
Received: from mercury.sdinet.de ([193.103.161.30]:1433 "EHLO
	mercury.sdinet.de") by vger.kernel.org with ESMTP id S964981AbWEORHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:07:08 -0400
Date: Mon, 15 May 2006 19:07:07 +0200 (CEST)
From: Sven-Haegar Koch <haegar@sdinet.de>
To: Jeff Garzik <jeff@garzik.org>
cc: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: SATA status report updated
In-Reply-To: <44689C39.70902@garzik.org>
Message-ID: <Pine.LNX.4.64.0605151901060.25784@mercury.sdinet.de>
References: <44689C39.70902@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2006, Jeff Garzik wrote:

> I've updated the http://linux-ata.org/ status pages with the recent work by 
> Tejun Heo and others.

Thanks for your list, but I'm missing the SATA chipset that our Asus-Boxes 
got:

0000:00:14.1 IDE interface: ATI Technologies Inc ATI Dual Channel Bus 
Master PCI IDE Controller
(PCI-ID 1002:4349)

Or is this something different like an IDE chipset with included SATA 
bridges or so?

It is supported through the atiixp ide driver, but only really slow 
(10mb/s) - the same disks attached to an Intel SATA port give 30-40mb/s.

c'ya
sven

-- 

The Internet treats censorship as a routing problem, and routes around it.
(John Gilmore on http://www.cygnus.com/~gnu/)
