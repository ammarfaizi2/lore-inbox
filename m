Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269028AbUI3GvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269028AbUI3GvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 02:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUI3GvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 02:51:20 -0400
Received: from cantor.suse.de ([195.135.220.2]:63700 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269028AbUI3GvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 02:51:16 -0400
Date: Thu, 30 Sep 2004 08:49:18 +0200
From: Olaf Hering <olh@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930064918.GA20357@suse.de>
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930064037.GA3167@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040930064037.GA3167@krispykreme.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Sep 30, Anton Blanchard wrote:

>  
> > This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
> > Hangs after 'returning from prom_init', wants a power cycle.
> 
> How much memory do you have? We might be filling up a hpte bucket
> completely with certain amounts of memory.

It has 4gig.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
