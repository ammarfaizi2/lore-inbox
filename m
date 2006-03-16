Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWCPSbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWCPSbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCPSbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:31:25 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:35283 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S932688AbWCPSbY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:31:24 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Thu, 16 Mar 2006 12:32:35 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A203222D@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZJIxF17t/UTHM/QnuaH8foO0geGAABFkzA
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "Stephen Hemminger" <shemminger@osdl.org>, "Chris Wedgwood" <cw@f00f.org>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
       "Bart Samwel" <bart@samwel.tk>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if they would be more open to accepting that patch now?

- Greg Scott
 

-----Original Message-----
From: Stephen Hemminger [mailto:shemminger@osdl.org] 
Sent: Thursday, March 16, 2006 11:55 AM
To: Chris Wedgwood
Cc: Greg Scott; Chuck Ebbert; linux-kernel; David S. Miller;
netdev@vger.kernel.org; Bart Samwel; Alan Cox; Simon Mackinlay
Subject: Re: Router stops routing after changing MAC Address

On Thu, 16 Mar 2006 08:07:43 -0800
Chris Wedgwood <cw@f00f.org> wrote:

> On Mon, Mar 13, 2006 at 10:00:41AM -0800, Stephen Hemminger wrote:
> 
> > There still is a bug in the 3c59x driver.  It doesn't include any 
> > code to handle changing the mac address.  It will work if you take 
> > the device down, change address, then bring it up. But you shouldn't

> > have to do that.
> 
> I sent a patch do to this probably a year or two back and it was 
> rejected (by akpm if I recall) because of the argument that you could 
> and should take it down, change the MAC and bring it back up.
> 
> Is this no longer a requirement?

No. most drivers allow changes on the fly.
