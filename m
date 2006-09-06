Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbWIFXYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbWIFXYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWIFXYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:24:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:20779 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1030204AbWIFXYM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:24:12 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,221,1154934000"; 
   d="scan'208"; a="126780495:sNHT1552252142"
Date: Wed, 6 Sep 2006 14:27:54 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Fernando Vazquez <fernando@oss.ntt.co.jp>,
       "David S. Miller" <davem@davemloft.net>, linux-ia64@vger.kernel.org,
       stable@kernel.org, xemul@openvz.org, devel@openvz.org
Subject: Re: [PATCH] IA64,sparc: local DoS with corrupted ELFs
Message-ID: <20060906212754.GA3222@intel.com>
References: <44FC193C.4080205@openvz.org> <Pine.LNX.4.64.0609061314430.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609061314430.27779@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2006 at 01:20:59PM -0700, Linus Torvalds wrote:
> Btw, is there some reason for the __ASSEMBLY__ check?

On ia64 entry.S includes asm/pgtable.h, which includes asm/mman.h

-Tony
