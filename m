Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUCQT3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 14:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUCQT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 14:29:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60340 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261981AbUCQT3R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 14:29:17 -0500
Message-ID: <4058A6FB.6080602@pobox.com>
Date: Wed, 17 Mar 2004 14:28:59 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: "Justin T. Gibbs" <Justin_Gibbs@adaptec.com>, linux-raid@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: "Enhanced" MD code avaible for review]
References: <405899E8.8070806@pobox.com> <20040317183756.GA23667@lst.de> <2241002704.1079549645@aslan.btc.adaptec.com> <20040317190117.GA23968@lst.de> <2260532704.1079550351@aslan.btc.adaptec.com> <20040317190916.GA24118@lst.de>
In-Reply-To: <20040317190916.GA24118@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(added linux-kernel to CC, where IMO the discussion on wider issues belongs)

Christoph Hellwig wrote:
> On Wed, Mar 17, 2004 at 12:05:51PM -0700, Justin T. Gibbs wrote:
>>I'm aware of Neil's past comments on the subject, but I was not aware
>>of a more full discussion on what this means in terms of lost functionality
>>for Linux.  I would like to have that discussion.  I'm more than willing
>>to adjust our strategy once that discussion takes place and a consensus
>>is reached.
> 
> 
> We're not far enough to actually removing functionlly yet.  For that
> early userspace needs to get a little more mature and more widely used.
> 
> We're not going to add more functionaly like that. though.

If early userspace isn't ready, it sounds like a choice between 
"nothing" and "it works".

We want a clean, tasteful solution, sure.  But I think we can work 
within the confines of the existing 2.6 API, and not postpone this stuff 
under early userspace is ready.

<rant>
Overall... the storage industry finally got off their ass and created a 
vendor-neutral RAID format, and they're actually using it.  Linux users 
don't deserve to be left out in the cold until 2.7.x klibc stuff is in, 
since they will be buying such RAID hardware right now.

I got into the Linux kernel game years ago in a large part because of 
precisely this -- getting Linux users going on hardware that would 
otherwise be Windows-only, without my help.  (or would otherwise be a 
grotty and buggy vendor driver, without my help:))
</rant>

	Jeff



