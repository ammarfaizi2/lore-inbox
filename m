Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbSLUAWR>; Fri, 20 Dec 2002 19:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLUAWR>; Fri, 20 Dec 2002 19:22:17 -0500
Received: from holomorphy.com ([66.224.33.161]:24264 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261290AbSLUAWQ>;
	Fri, 20 Dec 2002 19:22:16 -0500
Date: Fri, 20 Dec 2002 16:29:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021221002940.GM25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>,
	Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176730000.1040430221@aslan.btc.adaptec.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Janet Morgan had her attribution removed:
>> I have an Adaptec AIC-7897 Ultra2 SCSI adapter on a system with 8G
>> of physical memory.  The adapter is using bounce buffers when DMA'ing
>> to memory >4G because of a bug in the aic7xxx driver. 

On Fri, Dec 20, 2002 at 05:23:42PM -0700, Justin T. Gibbs wrote:
> This has been fixed in both the aic7xxx and aic79xx drivers for some
> time.  The problem is that these later revisions have not been integrated
> into the mainline trees.

Could you split up the new revisions into a series of reviewable
patches with clearly-defined individual scope and descriptive changelog
entries and post them (in your mail message, not as URL's) please? I
actually use this driver at home, so I'd like to be able to understand
what's going on with it. I suspect various others are of like mind.


Thanks,
Bill
