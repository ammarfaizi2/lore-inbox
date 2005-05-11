Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVEKWMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVEKWMq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVEKWMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:12:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:62897 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261346AbVEKWMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:12:36 -0400
X-Authenticated: #20450766
Date: Wed, 11 May 2005 23:26:20 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Vladislav Bolkhovitin <vst@vlnb.net>
cc: iscsitarget-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       dmitry_yus@yahoo.com, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: several messages
In-Reply-To: <4281C8A3.20804@vlnb.net>
Message-ID: <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
 <1115236116.7761.19.camel@dhollis-lnx.sunera.com> <1104082357.20050504231722@dns.toxicfilms.tv>
 <1115305794.3071.5.camel@dhollis-lnx.sunera.com> <20050507150538.GA800@favonius>
 <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <4281C8A3.20804@vlnb.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thanks for the replies

On Wed, 11 May 2005, FUJITA Tomonori wrote:
> The iSCSI protocol simply encapsulates the SCSI protocol into the
> TCP/IP protocol, and carries packets over IP networks. You can handle
...

On Wed, 11 May 2005, Vladislav Bolkhovitin wrote:
> Actually, this is property not of iSCSI target itself, but of any SCSI target.
> So, we implemented it as part of our SCSI target mid-level (SCST,
> http://scst.sourceforge.net), therefore any target driver working over it will
> automatically benefit from this feature. Unfortunately, currently available
> only target drivers for Qlogic 2x00 cards and for poor UNH iSCSI target (that
> works not too reliable and only with very specific initiators). The published
...

The above confirms basically my understanding apart from one "minor" 
confusion - I thought, that parallel to hardware solutions pure software 
implementations were possible / being developed, like a driver, that 
implements a SCSI LDD API on one side, and forwards packets to an IP 
stack, say, over an ethernet card - on the initiator side. And a counter 
part on the target side. Similarly to the USB mass-storage and storage 
gadget drivers?

Thanks
Guennadi
---
Guennadi Liakhovetski

