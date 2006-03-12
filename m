Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWCLThT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWCLThT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 14:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWCLThS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 14:37:18 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:58127 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S932069AbWCLThR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 14:37:17 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 12 Mar 2006 13:38:25 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321E0@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZGABEkqlXf9sq9S3GRm/3xz6UKkQAC5Ruw
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "Bart Samwel" <bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the NICs on all the systems are 3c905b's.  The system with the
2.4 kernel on it has them and I think that is what I put in my 2.6-11
test system as well.  My 2.6 system doesn't have a modules.conf file so
I will need to dig a little deeper.  I suppose I could just open it up
and look.  But I am almost sure I put 3c905b cards in both test systems.

- Greg

 

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Sunday, March 12, 2006 12:14 PM
To: Greg Scott
Cc: linux-kernel@vger.kernel.org; Bart Samwel
Subject: RE: Router stops routing after changing MAC Address

On Sul, 2006-03-12 at 09:34 -0600, Greg Scott wrote:
> Bart and I had a private discussion about this.  I was able to prove 
> that routing stops when "fudged" MAC Addresses on the router don't 
> match the hardware MAC Addresses.  And routing starts back up again 
> when the I change the "fudged" MAC Addresses back to match the 
> hardware MAC Addresses.

Which driver, and does it occur with other drivers. Also you really want
to move this to netdev@oss.sgi.com to get the best network folks to see
it.

