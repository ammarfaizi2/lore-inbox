Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAISEz>; Tue, 9 Jan 2001 13:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbRAISEq>; Tue, 9 Jan 2001 13:04:46 -0500
Received: from mail2.megatrends.com ([155.229.80.11]:23820 "EHLO
	mail2.megatrends.com") by vger.kernel.org with ESMTP
	id <S129324AbRAISEb>; Tue, 9 Jan 2001 13:04:31 -0500
Message-ID: <1355693A51C0D211B55A00105ACCFE64E9513E@ATL_MS1>
From: Venkatesh Ramamurthy <Venkateshr@ami.com>
To: "'Andi Kleen'" <ak@suse.de>, Matti Aarnio <matti.aarnio@zmailer.org>,
        Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'Pavel Machek'" <pavel@suse.cz>, adefacc@tin.it,
        linux-kernel@vger.kernel.org
Cc: timw@splhi.com
Subject: RE: Confirmation request about new 2.4.x. kernel limits
Date: Tue, 9 Jan 2001 13:00:03 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Jan 09, 2001 at 08:27:49AM -0800, Tim Wright wrote:
> > you are correct in saying that ia32 systems don't have IOMMU hardware,
> but
> > it's unfortunate that we don't support 64-bit PCI bus master cards,
> since
> > they're inexpensive and fairly common now. For instance, the Qlogic ISP
> SCSI
> > cards can do 64-bit addressing, as can many others. Has anybody taken a
> look
> > at enabling this ?
	[Venkatesh Ramamurthy]  Our AMI RAID controller and MegaRAID driver
( part of kernel) supports full blown 64 bit and we have successfully tested
with more than 4 GB RAM under IA32 (uses bounce buffer) and IA64 systems. We
are seeing a dramatic performance drop on IA32 with 8GB ram as it has to do
bounce buffering. I think we need this support to give our dear old linux a
lead compared to other OS'es.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
