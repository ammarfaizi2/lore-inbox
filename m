Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUERTxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUERTxF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263309AbUERTxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:53:04 -0400
Received: from main.gmane.org ([80.91.224.249]:32231 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263185AbUERTxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:53:00 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: libata 2.6.5->2.6.6 regression -part II
Date: Tue, 18 May 2004 23:52:57 +0400
Message-ID: <pan.2004.05.18.19.52.56.742751@altlinux.ru>
References: <40A8E9A8.3080100@wasp.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213.177.124.23
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2004 20:34:48 +0400, Brad Campbell wrote:

> Is there any way I can prevent the VIA ATA driver capturing this device?
> Unfortunately my boot drive is on hda on the on-board VIA ATA interface so
> I need it compiled in.

VIA8237SATA is really handled by the "Generic PCI IDE Chipset Support"
driver (CONFIG_BLK_DEV_GENERIC), so you can disable it without losing
support for your on-board VIA vt8237 (CONFIG_BLK_DEV_VIA82CXXX).


