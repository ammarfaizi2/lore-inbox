Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbUKQSE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUKQSE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUKQSCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:02:39 -0500
Received: from emulex.emulex.com ([138.239.112.1]:9405 "EHLO emulex.emulex.com")
	by vger.kernel.org with ESMTP id S262456AbUKQSB4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:01:56 -0500
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Potential issue with some implementations of pci_resource_start()
Date: Wed, 17 Nov 2004 12:54:25 -0500
Message-ID: <0B1E13B586976742A7599D71A6AC733C12E722@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Potential issue with some implementations of pci_resource_start()
Thread-Index: AcTMzSOXb9UWK5sYQyu45gmOn2xdqgAAOLBQ
To: <greg@kroah.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-os@chaos.analogic.com>,
       <jes@wildopensource.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started to - but had no idea what pci_resource_end() would correspond to. I'm guessing it's "cookie + N" where N is the size of the BAR. However, this seems really odd and would only be used to calculate the size of N. I figured someone actually in tune with the pci subsytem was better qualified to write the summary.

-- James


> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: Wednesday, November 17, 2004 12:45 PM
> To: Smart, James
> Cc: linux-kernel@vger.kernel.org; linux-os@chaos.analogic.com;
> jes@wildopensource.com
> Subject: Re: Potential issue with some implementations of
> pci_resource_start()
> 
> 
> On Wed, Nov 17, 2004 at 09:18:27AM -0500, 
> James.Smart@Emulex.Com wrote:
> > 
> > Can someone please update Documentation/pci.txt so that it 
> has correct
> > definitions for pci_resource_start() and pci_resource_end()...
> 
> Patches gladly accepted for this.  And as you now know exactly what is
> missing, you might be the best person to write such a patch :)
> 
> thanks,
> 
> greg k-h
> 
