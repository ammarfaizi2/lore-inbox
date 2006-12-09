Return-Path: <linux-kernel-owner+w=401wt.eu-S935686AbWLIIRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935686AbWLIIRG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 03:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935728AbWLIIRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 03:17:05 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:43482 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935686AbWLIIRE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 03:17:04 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Ben Nizette <ben.nizette@iinet.net.au>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Date: Sat, 9 Dec 2006 09:18:26 +0100
User-Agent: KMail/1.8
Cc: Matthias Schniedermeyer <ms@citd.de>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       DervishD <lkml@dervishd.net>
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <200612081201.36789.oliver@neukum.org> <457A5384.9070806@iinet.net.au>
In-Reply-To: <457A5384.9070806@iinet.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612090918.26508.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. Dezember 2006 07:11 schrieb Ben Nizette:
> >>> Also, you mentioned that the corruption occurs systematically on certain
> >>> byte patterns. Therefore it's certainly not related to the cables.
> >> It'd guess that too, but who can that say for sure. :-|
> > 
> > You may have a bit pattern that stresses the controllers and suddenly
> > a marginal cable may matter.
> 
> The errors occur in strings of 0xFFs.  From the USB standard:
> 
> a “1” is represented by no change in level and a “0” is represented by a 
> change in level

Yes, plus added stuffing bits.

> so this error-infested bytes are effectively long, quiet times on the 
> wire.  I would have thought this would be the _least_ stressful time for 
> the controllers but maybe they are also more susceptible to noise during 
> this period.

The longer you don't change the voltage the likelier are reciever and
transmitter to get out of sync.

	Regards
		Oliver
