Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUI3GoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUI3GoQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268900AbUI3GoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:44:16 -0400
Received: from ozlabs.org ([203.10.76.45]:19403 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268677AbUI3GoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:44:13 -0400
Date: Thu, 30 Sep 2004 16:40:37 +1000
From: Anton Blanchard <anton@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930064037.GA3167@krispykreme.ozlabs.ibm.com>
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040929194730.GA6292@suse.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> Hangs after 'returning from prom_init', wants a power cycle.

How much memory do you have? We might be filling up a hpte bucket
completely with certain amounts of memory.

Anton
