Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268836AbUI3IUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbUI3IUp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 04:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268955AbUI3IUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 04:20:45 -0400
Received: from cantor.suse.de ([195.135.220.2]:9903 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268836AbUI3IUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 04:20:44 -0400
Date: Thu, 30 Sep 2004 10:20:42 +0200
From: Olaf Hering <olh@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PPC64] Improved VSID allocation algorithm
Message-ID: <20040930082042.GA27980@suse.de>
References: <20040913041119.GA5351@zax> <20040929194730.GA6292@suse.de> <20040930064037.GA3167@krispykreme.ozlabs.ibm.com> <20040930070151.GG21889@zax> <20040930080510.GH21889@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040930080510.GH21889@zax>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Sep 30, David Gibson wrote:
> changing VSID_MULTIPLIER in include/asm-ppc64/mmu.h to 200730139,
> instead of the current value.  According to my hash simulator that
> should fix the problem for you (and work out to larger amounts of RAM,
> too).

Yes, that number works, tested on rc2 + the vsid patch.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
