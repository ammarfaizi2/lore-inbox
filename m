Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319124AbSIJOBn>; Tue, 10 Sep 2002 10:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319125AbSIJOBn>; Tue, 10 Sep 2002 10:01:43 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:22545 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S319124AbSIJOBm> convert rfc822-to-8bit; Tue, 10 Sep 2002 10:01:42 -0400
x-mimeole: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? 
Date: Tue, 10 Sep 2002 09:06:21 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E1064012814A8@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: [RFC] Multi-path IO in 2.5/2.6 ? 
Thread-Index: AcJY0z3ARLDNg0PRTxujdTdQlRy1Ag==
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 10 Sep 2002 14:06:22.0745 (UTC) FILETIME=[3E5D7090:01C258D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:

>Answer me this question:
>- In the forseeable future does multi-path have uses other than SCSI?

We (HP) would like to use multipath i/o with the cciss driver.
(which is a block driver).

We can use the md driver for this.  However, we cannot boot from
such a multipath device.  Lilo and grub do not understand md multipath
devices, nor do anaconda or other installers.  (Enhancing all of those,
I'd like to avoid.  Cramming multipath i/o into the low level driver
would accomplish that, but, too yucky.) 

If there is work going on to enhance the multipath support in linux
it would be nice if you could boot from and install to such devices.

-- steve
