Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTFCDsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 23:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFCDsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 23:48:19 -0400
Received: from rth.ninka.net ([216.101.162.244]:4235 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S264922AbTFCDsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 23:48:19 -0400
Subject: Re: 2.5.70-bk7 -- drivers/net/irda/w83977af_ir.ko needs unknown
	symbol setup_dma
From: "David S. Miller" <davem@redhat.com>
To: Miles Lane <miles.lane@attbi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3EDBCC44.8000009@attbi.com>
References: <3EDBCC44.8000009@attbi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054612898.9352.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 21:01:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 15:14, Miles Lane wrote:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.70-bk7; fi
> WARNING: /lib/modules/2.5.70-bk7/kernel/drivers/net/irda/w83977af_ir.ko 
> needs unknown symbol setup_dma

What platform is this?  It needs to set CONFIG_ISA correctly.

-- 
David S. Miller <davem@redhat.com>
