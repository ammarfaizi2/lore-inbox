Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVLTRFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVLTRFp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 12:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVLTRFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 12:05:45 -0500
Received: from web50114.mail.yahoo.com ([206.190.39.162]:48513 "HELO
	web50114.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750732AbVLTRFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 12:05:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iHZlwa6yplISHjt0kcjxaBgjk8jg2O32gJLyPsApa0iI3RRUwG8UgqAtraGJkWFwTttfThoDyBbGziDB3rzKNZIzRmwVy1W2NjLF0B5dTY5xw67qHuxHicZY5NSB8RdHwe/HRVELx2G7qfrPC1g8iHj6ddbass19VhV30owInBw=  ;
Message-ID: <20051220170542.60920.qmail@web50114.mail.yahoo.com>
Date: Tue, 20 Dec 2005 09:05:41 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [PATCH]  EDAC with sysfs interface added
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43A81031.8040708@g-house.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Christian Kujau <evil@g-house.de> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: RIPEMD160
> 
> Doug Thompson schrieb:
> > From:   doug thompson  <norsk5@xmission.com>
> > 
> > Patch against 2.6.15-rc5-mm3
> > 
> > EDAC has been modifed to remove old interface and add new interface.
> 
> hi Doug, i've seen you answering a problem i still have with 2.6.15-rc5-mm3:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0512.0/0529.html
> 
> i just want to post a "me too" here along with lspci, because you inteded
> to add black/whitelists to this EDAC thingy, maybe it is of some help:
> 
> http://www.nerdbynature.de/bits/prinz64/2.6.15-rc5-mm3/
> 
> thanks,
> Christian.
> - --

You reminded me that I failed to put in the summary that whitelist/blacklist ARE in this patch as
well as the sysfs. Apply the patch, and set your white or black list with the vendor_id:device_id
that you desire. This needs to be done after bootup.

We plan on some userspace script for initializing EDAC, etc. But we need it in the kernel first. 
We will put such at bluesmoke.sourceforge.net

doug thompson


