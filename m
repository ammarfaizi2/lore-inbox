Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVCJPSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVCJPSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 10:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVCJPSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 10:18:37 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:12256 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262636AbVCJPSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 10:18:17 -0500
Subject: Re: [BUG] 2.6.11- sym53c8xx Broken on pp64
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Omkhar Arasaratnam <iamroot@ca.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, tgall@us.ibm.com,
       antonb@au1.ibm.com
In-Reply-To: <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>
References: <422FA817.4060400@ca.ibm.com>
	 <1110420620.32525.145.camel@gaston> <422FBACF.90108@ca.ibm.com>
	 <422FC042.40303@ca.ibm.com>
	 <Pine.LNX.4.58.0503091944030.2530@ppc970.osdl.org>
	 <1110434383.32525.184.camel@gaston>
	 <20050310121701.GD21986@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Date: Thu, 10 Mar 2005 17:17:48 +0200
Message-Id: <1110467868.5379.15.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-10 at 12:17 +0000, Matthew Wilcox wrote:
> Heh, the devel version of sym2 (that isn't submitted yet because
> it depends on a few changes to the SPI transport that James hasn't
> integrated yet) would probably fix this as it doesn't call iounmap()
> until the driver exits.

They're integrated into the scsi-misc-2.6 tree, so if you send in the
sym2 patch to linux-scsi, everything should still work...

James


