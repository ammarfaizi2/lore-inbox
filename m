Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVIFFKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVIFFKy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 01:10:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVIFFKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 01:10:54 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:22214 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id S932306AbVIFFKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 01:10:54 -0400
From: Oliver Tennert <O.Tennert@science-computing.de>
To: Mark Lord <lkml@rtr.ca>
Subject: Re: DVD+-R[W] regression in 2.6.12/13
Date: Tue, 6 Sep 2005 07:10:41 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200509051533.01465.tennert@science-computing.de> <431C7131.3030506@rtr.ca> <431C71D4.8070402@rtr.ca>
In-Reply-To: <431C71D4.8070402@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060710.42100.tennert@science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 5. September 2005 18:27, Mark Lord wrote:
> Oh, you *should* be able to get the results you
> are looking for (hdparm -I) by trying it this way:
>
>     hdparm --Istdin </proc/ide/hdd/identify
>
> Cheers

Oh yes, you are right! It works. But what is the reason behind this new 
behaviour?

Best regards

Oliver

-- 
I used to work in a fire hydrant factory.  You couldn't park anywhere
near the place.
		-- Steven Wright
--
__
________________________________________creating IT solutions

Dr. Oliver Tennert
Senior Solutions Engineer
CAx Professional Services
                                        science + computing ag
phone   +49(0)7071 9457-598             Hagellocher Weg 71-75	
fax     +49(0)7071 9457-411             D-72070 Tuebingen, Germany
O.Tennert@science-computing.de          www.science-computing.de


