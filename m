Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbUBCBi6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUBCBi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:38:58 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24025 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S265816AbUBCBi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:38:56 -0500
Date: Tue, 03 Feb 2004 10:38:52 +0900 (JST)
Message-Id: <20040203.103852.74728002.marc@labs.fujitsu.com>
To: woody@co.intel.com
Cc: hozer@hozed.org, infiniband-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the
 linux kernel
From: Masanori ITOH <marc@labs.fujitsu.com>
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Folks,

Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
> 
> We were waiting until we had some version of the InfiniBand code ported
> to 2.6 before
> asking for it to be included in the 2.6 kernel tree. Jerrie made the
> changes
> to the IB access layer to allow it to compile on 2.6, but it cannot yet
> be tested 
> till we get a 2.6 driver from Mellanox. 

Now, I'm testing a VPD for Fujitsu InfiniBand HCA card.
The VPD requires no special SDK such as VAPI of Mellanox.

In order to do that, I made some changes locally on IBAL and COMPLIB layers
based on the change set 1.207. I still have some problems, but opensm and
ipoib are working on linux-2.6.1 environment.

Robert, if you could make Jarrie's modification public at bkbits.net,
I can test the modification for 2.6 kernel using Fujitsu HCA.

Meanwhile, Mellanox is not the only supplier of InfiniBand HCA.
Fujitsu, Japan, also has InfiniBand HCA card with an original LSI 
different from Tavor chip.

Thanks in advance,
Masanori

> I'd also like to hear from the linux-kernel folks on what we would need
> to
> do to get a basic InfiniBand access layer included in the 2.6 base. 
> 
> We'd also like to hear from Mellanox if they have any plans to provide
> an open
> source VPD driver anytime soon. 
> 
> woody

---
Masanori ITOH  Grid Computing & Bioinformatics Lab., Fujitsu Labs. LTD.
               e-mail: marc@labs.fujitsu.com
               phone: +81-44-754-2628 (extension: 7112-6227)
               FingerPrint: 55AF C562 E415 FB1A 8A3A  35D1 AB40 8A9D B8B1 99F8
