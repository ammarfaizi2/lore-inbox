Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbUKXJBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbUKXJBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbUKXJBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:01:11 -0500
Received: from inet-tsb.toshiba.co.jp ([202.33.96.40]:55968 "EHLO
	inet-tsb.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S262537AbUKXJBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:01:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: linux-2.4.28 released
Date: Wed, 24 Nov 2004 17:57:46 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF062D0B5@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Thread-Topic: linux-2.4.28 released
Thread-Index: AcTORf1Om5KXjiueTn+DtNvOdn2SeQDi041w
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: "Jeff Garzik" <jgarzik@pobox.com>, "Alan Cox" <alan@redhat.com>
Cc: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>,
       "Marcelo Tosatti" <marcelo@hera.kernel.org>,
       <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not writing you soon.

Jeff Garzik wrote:

> >>PATA and SATA (DMA doesn't work for PATA, in split-driver 
> configuration),
> >>and there is no split-driver to worry about.
> >>
> >>I think there may need to be some code to prevent the IDE 
> driver from
> >>claiming the legacy ISA ports.
> > 
> > 
> > Its called "request_resource". If you want the resource 
> claim it. IDE will
> > be a good citizen.
> 
> That's what the quirk does.  libata still needs to find out 
> who obtained the resource, not blindly grab it (and fail).

I also think so. 

It may be unavoidable one that ata_piix does not work. 
But, it is a problem that a DMA transfer does not enable by piix. 
Don't you think so?
--
Haruo
