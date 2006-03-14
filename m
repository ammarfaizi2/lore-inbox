Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWCNP3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWCNP3S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWCNP3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:29:17 -0500
Received: from mail.infrasupportetc.com ([66.173.97.5]:47975 "EHLO
	mail733.InfraSupportEtc.com") by vger.kernel.org with ESMTP
	id S1751418AbWCNP3Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:29:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Router stops routing after changing MAC Address
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
Date: Tue, 14 Mar 2006 09:30:25 -0600
Message-ID: <925A849792280C4E80C5461017A4B8A20321FD@mail733.InfraSupportEtc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Router stops routing after changing MAC Address
Thread-Index: AcZHZjB9yiczdsUbRiak9CXAdmXMSQAE8wKQ
From: "Greg Scott" <GregScott@InfraSupportEtc.com>
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>,
       "Bart Samwel" <bart@samwel.tk>
Cc: "Rick Jones" <rick.jones2@hp.com>,
       "Chuck Ebbert" <76306.1226@compuserve.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Simon Mackinlay" <smackinlay@mail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yet I have real-world examples I've seen with my own eyes where MAC
Address problems have messed up bridged networks.  I posted some of
those here yesterday.  Good old Ethernet MAC Addresses can and do play a
real role in these wide area networks.  

Don't believe me?  Try it yourself.  Find a LAN connected to the
Internet via bridged DSL or cablemodem with a real firewall in place.
Swap the firewall and wait...and wait...and wait some more for ARP
caches to clear on the other end.  

When nothing changes but the passage of time and traffic starts to flow
again - and the Internet service is bridged not routed - give me another
explanation besides ARP caches.  

- Greg



-----Original Message-----
From: linux-os (Dick Johnson) [mailto:linux-os@analogic.com] 
Sent: Tuesday, March 14, 2006 6:53 AM
To: Bart Samwel
Cc: Greg Scott; Rick Jones; Chuck Ebbert; linux-kernel;
netdev@vger.kernel.org; Alan Cox; Simon Mackinlay
Subject: Re: Router stops routing after changing MAC Address


On Tue, 14 Mar 2006, Bart Samwel wrote:

> linux-os (Dick Johnson) wrote:
>> On Mon, 13 Mar 2006, Greg Scott wrote:
>> Bzzzzst... Not! There are not any MAC addresses associated with any 
>> of the intercity links, usually not even in WANs!  MAC is for 
>> Ethernet! Once you go to fiber, ATM, T-N, etc., there are no MAC
addresses.
>
> Bzzzzt. According to WikiPedia:
>
> http://en.wikipedia.org/wiki/MAC_address
>
> MAC addresses are used for:
>
> - Token ring
> - 802.11 wireless networks
> - Bluetooth
> - FDDI
> - ATM (switched virtual connections only, as part of an NSAP address)
> - SCSI and Fibre Channel (as part of a World Wide Name)
>
> FDDI = fiber, ATM = ATM.
>
> --Bart
>

A name is NOT.  I can call my mail route number RFD#2 a MAC address.
Also token-ring is a form of Ethernet as are all known wireless networks
unless they use light. Even cable modems use Ethernet, with FDM on the
cable side and baseband on the customer side. Calling SCSI MAC is
absurd. All of the above, except the ethernets are forms of
point-to-point communications links. IP (over/under or through) these
links uses a source and destination IP and any hardware addressing
scheme is incidental.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.15.4 on an i686 machine (5589.54 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be
privileged.  Any review, retransmission, dissemination, or other use of
this information by persons or entities other than the intended
recipient is prohibited.  If you are not the intended recipient, please
notify Analogic Corporation immediately - by replying to this message or
by sending an email to DeliveryErrors@analogic.com - and destroy all
copies of this information, including any attachments, without reading
or disclosing them.

Thank you.
