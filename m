Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbULCBOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbULCBOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261836AbULCBOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:14:35 -0500
Received: from 76.80-203-227.nextgentel.com ([80.203.227.76]:35040 "EHLO
	mail.inprovide.com") by vger.kernel.org with ESMTP id S261833AbULCBOa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:14:30 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dma errors with sata_sil and Seagate disk
References: <20041201115045.3ab20e03@homer.sarvega.com>
	<1101944482.30990.74.camel@localhost.localdomain>
	<yw1xpt1tuihe.fsf@ford.inprovide.com>
	<1102030431.7175.9.camel@localhost.localdomain>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Date: Fri, 03 Dec 2004 02:14:27 +0100
In-Reply-To: <1102030431.7175.9.camel@localhost.localdomain> (Alan Cox's
 message of "Thu, 02 Dec 2004 23:33:53 +0000")
Message-ID: <yw1xvfbkrxn0.fsf@ford.inprovide.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.ak> writes:

> On Iau, 2004-12-02 at 10:01, Måns Rullgård wrote:
>> Is there some problem with Seagate drives in general?  I'm using two
>> ST3160827AS drives on an SI3114 controller, and haven't seen any
>> glitches yet.  That model is not in the blacklist, and performance is
>> what I'd usually expect.  Is it pure luck that has kept me away from
>> problems?
>
> I've never been able to get a non NDA list of the affected drives. Got
> to love vendors some days

Does this mean it is the drives which are faulty, not the controller?
These drives are both new, so I suppose known problems might have been
fixed.  FWIW, they are reported by the kernel thusly:

  Vendor: ATA       Model: ST3160827AS       Rev: 3.03
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3160827AS       Rev: 3.00
  Type:   Direct-Access                      ANSI SCSI revision: 05

-- 
Måns Rullgård
mru@inprovide.com
