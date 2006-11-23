Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933721AbWKWTyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbWKWTyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 14:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbWKWTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 14:53:59 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58261
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933721AbWKWTx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 14:53:58 -0500
Date: Thu, 23 Nov 2006 11:54:03 -0800 (PST)
Message-Id: <20061123.115403.84973519.davem@davemloft.net>
To: arjan@infradead.org
Cc: netdev@axxeo.de, dgc@sgi.com, jesper.juhl@gmail.com,
       chatz@melbourne.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to
 implicate xfs, scsi, networking, SMP
From: David Miller <davem@davemloft.net>
In-Reply-To: <1164307020.3147.3.camel@laptopd505.fenrus.org>
References: <20061123070837.GV11034@melbourne.sgi.com>
	<200611231416.03387.netdev@axxeo.de>
	<1164307020.3147.3.camel@laptopd505.fenrus.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arjan van de Ven <arjan@infradead.org>
Date: Thu, 23 Nov 2006 19:37:00 +0100

> On Thu, 2006-11-23 at 14:16 +0100, Ingo Oeser wrote:
> > Hi there,
> > 
> > David Chinner schrieb:
> > > If the softirqs were run on a different stack, then a lot of these
> 
> softirqs DO run on their own stack!

This is a platform specific assertion :-)
