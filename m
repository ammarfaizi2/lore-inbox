Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318410AbSGYLNI>; Thu, 25 Jul 2002 07:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318411AbSGYLNI>; Thu, 25 Jul 2002 07:13:08 -0400
Received: from mailf.telia.com ([194.22.194.25]:51437 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S318410AbSGYLNH>;
	Thu, 25 Jul 2002 07:13:07 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Safety of IRQ during i/o
Date: Thu, 25 Jul 2002 13:15:30 +0200
User-Agent: KMail/1.4.5
References: <Pine.SOL.4.30.0207250041400.15959-100000@mion.elka.pw.edu.pl> <1027592784.9489.11.camel@irongate.swansea.linux.org.uk> <3D3FC625.1020202@evision.ag>
In-Reply-To: <3D3FC625.1020202@evision.ag>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200207251315.30566.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 July 2002 11.34, Marcin Dalecki wrote:
> Alan Cox wrote:
> > For old ISA/VLB controllers its safer left as is, and nobody running a
> > machine like that can realistically expect good performance without hand
> > tuning stuff anyway
> 
> Sounds fairly well and is easy to implement...just adding
> 
> if (ch->pci_dev != NULL && ch->umask)
> 
> at the corresponding plase in ata_irq_request will do the trick.
> 

Yea, but I lake to be able to see that it is enabled with hdparm
(and to be able to disable it as well...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

