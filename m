Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268916AbUI2TtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268916AbUI2TtP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268907AbUI2TtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 15:49:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:59577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268854AbUI2Trb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 15:47:31 -0400
Date: Wed, 29 Sep 2004 21:47:30 +0200
From: Olaf Hering <olh@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040929194730.GA6292@suse.de>
References: <20040913041119.GA5351@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040913041119.GA5351@zax>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 13, David Gibson wrote:

> Andrew, please apply.  This patch has been tested both on SLB and
> segment table machines.  This new approach is far from the final word
> in VSID/context allocation, but it's a noticeable improvement on the
> old method.

This patch went into 2.6.9-rc2-bk2, and my p640 does not boot anymore.
Hangs after 'returning from prom_init', wants a power cycle.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
