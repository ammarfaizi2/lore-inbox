Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264650AbTFLAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTFLAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:34:59 -0400
Received: from dp.samba.org ([66.70.73.150]:37523 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264650AbTFLAe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:34:58 -0400
Date: Thu, 12 Jun 2003 10:37:16 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: Re: pci_domain_nr vs. /sys/devices
Message-ID: <20030612003715.GA1942@krispykreme>
References: <1055341842.754.3.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055341842.754.3.camel@gaston>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> So we can pave the way for when we'll stop play bus number tricks and
> actually have overlapping PCI bus numbers between domains. (I don't plan
> to do that immediately because that would break userland & /proc/bus/pci
> backward compatiblity)

As davem suggested, /proc/bus/pci should present domain 0 in the old
format even with pci domains enabled. If your graphics card is on domain
0 then X continues to work :)

Anton
