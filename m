Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270373AbTGRWgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271903AbTGRWgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:36:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:7128
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271906AbTGRWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:36:15 -0400
Subject: Re: [PATCH] siimage.c - turning DMA on because of 'md' kernel
	thread.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kresimir Kukulj <madmax@iskon.hr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030718223425.GA21110@max.zg.iskon.hr>
References: <20030718223425.GA21110@max.zg.iskon.hr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058568523.19558.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jul 2003 23:48:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-07-18 at 23:34, Kresimir Kukulj wrote:
> resync.  That means that disks are busy (in PIO mode), and when hdparm -d1 -X69
> executes, system freezes [if there is no disk/little activity hdparm cludge
> passes ok - for example, if RAID-1 is clean so there is no resync].

The newest driver should put them into DMA automatically and set the
limit. The other changes I'll check over but certainly look like they
may be needed.

