Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVELScl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVELScl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVELSck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:32:40 -0400
Received: from smtp110.mail.sc5.yahoo.com ([66.163.170.8]:356 "HELO
	smtp110.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262104AbVELScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:32:19 -0400
Subject: Re: several messages
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: mingz@ele.uri.edu
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Vladislav Bolkhovitin <vst@vlnb.net>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       linux-scsi <linux-scsi@vger.kernel.org>, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1115864176.5513.37.camel@localhost.localdomain>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <4281C8A3.20804@vlnb.net>
	 <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
	 <1115864176.5513.37.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 May 2005 11:32:12 -0700
Message-Id: <1115922732.25161.143.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-11 at 22:16 -0400, Ming Zhang wrote:
> iscsi is scsi over ip.

correction. iSCSI today has RFC at least for two transports - TCP/IP and
iSER/RDMA(in finalized progress) with RDMA over Infiniband or RNIC. And
I think people start writing initial draft for SCTP/IP transport...

>From this perspective, iSCSI certainly more advanced and matured
comparing to NBD variations. 

> usb disk is scsi over usb.
> so just a different transport.
> u are rite. ;)
> 
> ming
> 
> On Wed, 2005-05-11 at 23:26 +0200, Guennadi Liakhovetski wrote:
> > Hello and thanks for the replies
> > 
> > On Wed, 11 May 2005, FUJITA Tomonori wrote:
> > > The iSCSI protocol simply encapsulates the SCSI protocol into the
> > > TCP/IP protocol, and carries packets over IP networks. You can handle
> > ...
> > 
> > On Wed, 11 May 2005, Vladislav Bolkhovitin wrote:
> > > Actually, this is property not of iSCSI target itself, but of any SCSI target.
> > > So, we implemented it as part of our SCSI target mid-level (SCST,
> > > http://scst.sourceforge.net), therefore any target driver working over it will
> > > automatically benefit from this feature. Unfortunately, currently available
> > > only target drivers for Qlogic 2x00 cards and for poor UNH iSCSI target (that
> > > works not too reliable and only with very specific initiators). The published
> > ...
> > 
> > The above confirms basically my understanding apart from one "minor" 
> > confusion - I thought, that parallel to hardware solutions pure software 
> > implementations were possible / being developed, like a driver, that 
> > implements a SCSI LDD API on one side, and forwards packets to an IP 
> > stack, say, over an ethernet card - on the initiator side. And a counter 
> > part on the target side. Similarly to the USB mass-storage and storage 
> > gadget drivers?
> > 
> > Thanks
> > Guennadi
> > ---
> > Guennadi Liakhovetski
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

