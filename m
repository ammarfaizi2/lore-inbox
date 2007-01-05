Return-Path: <linux-kernel-owner+w=401wt.eu-S1750773AbXAEVPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXAEVPR (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXAEVPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:15:17 -0500
Received: from mail-gw3.adaptec.com ([216.52.22.36]:41671 "EHLO
	mail-gw3.adaptec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbXAEVPQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:15:16 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: udev/aacraid interaction - should aacraid set 'removable'?
Date: Fri, 5 Jan 2007 16:15:13 -0500
Message-ID: <AE4F746F2AECFC4DA4AADD66A1DFEF0134FEBF@otce2k301.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: udev/aacraid interaction - should aacraid set 'removable'?
Thread-Index: AccxBgRT/J7Xv86OSjWi4TeYmAtL2gAB2lJg
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "dann frazier" <dannf@dannf.org>
Cc: <linux-kernel@vger.kernel.org>, <md@Linux.IT>, <404927@bugs.debian.org>,
       <404927-submitter@bugs.debian.org>, <debian-kernel@lists.debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not have any close at hand (cleaned out the hardware closet to
hazardous waste) :-(

But, as far as I am concerned :-), if it says 'DPT' or 'Adaptec' as the
manufacturer's name portion of the inquiry field, or has 'RAID' or
'Array' somewhere in the product name inquiry field, you have covered
most, if not all, of the possibilities I can come up with!

Hope that helps.

Sincerely -- Mark Salyzyn

> -----Original Message-----
> From: dann frazier [mailto:dannf@dannf.org] 
> Sent: Friday, January 05, 2007 3:14 PM
> To: Salyzyn, Mark
> Cc: linux-kernel@vger.kernel.org; md@Linux.IT; 
> 404927@bugs.debian.org; 404927-submitter@bugs.debian.org; 
> debian-kernel@lists.debian.org
> Subject: Re: udev/aacraid interaction - should aacraid set 
> 'removable'?
> 
> 
> On Wed, Jan 03, 2007 at 12:17:47PM -0500, Salyzyn, Mark wrote:
> > The ips driver, indirectly via Firmware as it spoofs it's 
> own inquiry
> > data, reports the Removable bit set in the inquiry response for the
> > arrays. The dpt_i2o driver similarly has the firmware 
> constructing the
> > bit set. Some of the Array Bridges and external RAID boxes 
> do the same
> > thing.
> 
> Thanks Mark. If you have any of these devices, could you help supply
> the udevinfo information? Our udev maintainer has asked for this so
> that he can workaround this issue by special casing these
> devices. (See http://bugs.debian.org/404927 for details).
> 
> -- 
> dann frazier
> 
> 
