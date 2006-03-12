Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWCLUu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWCLUu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 15:50:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWCLUu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 15:50:59 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:31250 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S932192AbWCLUu7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 15:50:59 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Sun, 12 Mar 2006 14:52:06 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321E6@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZGFngIecrfkYMJRzOmwudqnSGJpgAAFeAg
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, "Bart Samwel" <bart@samwel.tk>,
       <netdev@oss.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No - tried that earlier, no effect.  I also deleted and recreated all
the routes.  Again, no effect.  

- Greg
 

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk] 
Sent: Sunday, March 12, 2006 2:55 PM
To: Greg Scott
Cc: linux-kernel@vger.kernel.org; Bart Samwel
Subject: RE: Router stops routing after changing MAC Address

On Sul, 2006-03-12 at 13:38 -0600, Greg Scott wrote:
> I think the NICs on all the systems are 3c905b's.  The system with the
> 2.4 kernel on it has them and I think that is what I put in my 2.6-11 
> test system as well.  My 2.6 system doesn't have a modules.conf file 
> so I will need to dig a little deeper.  I suppose I could just open it

> up and look.  But I am almost sure I put 3c905b cards in both test
systems.

Humm - do they start routing correctly if you "ifconfig eth0 promisc"
(where eth0 is each interface whose mac you changed) ?

