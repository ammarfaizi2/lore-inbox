Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938024AbWLHLAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938024AbWLHLAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938025AbWLHLAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:00:22 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:57023 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425360AbWLHLAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:00:20 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Matthias Schniedermeyer <ms@citd.de>
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
Date: Fri, 8 Dec 2006 12:01:36 +0100
User-Agent: KMail/1.8
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       DervishD <lkml@dervishd.net>
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <45793D82.1040807@s5r6.in-berlin.de> <457940DC.90403@citd.de>
In-Reply-To: <457940DC.90403@citd.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612081201.36789.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 8. Dezember 2006 11:39 schrieb Matthias Schniedermeyer:
> > I.e. it's nearly impossible for noisy hardware to _silently_ cause data
> > corruption. I would suppose USB has similar CRC checks.

It has.

> > Also, you mentioned that the corruption occurs systematically on certain
> > byte patterns. Therefore it's certainly not related to the cables.
> 
> It'd guess that too, but who can that say for sure. :-|

You may have a bit pattern that stresses the controllers and suddenly
a marginal cable may matter.

	Regards
		Oliver

