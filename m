Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263701AbUDUVD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbUDUVD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUDUVD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:03:58 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:43712 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263701AbUDUVDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:03:55 -0400
Date: Wed, 21 Apr 2004 15:04:10 -0600
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The missing RAID level
Message-ID: <20040421210410.GA3814@bounceswoosh.org>
Mail-Followup-To: Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	linux-kernel@vger.kernel.org
References: <045P8FJ12@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <045P8FJ12@server5.heliogroup.fr>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20 at 19:50, Hubert Tonneau wrote:
>Assuming that I want to do long term archiving (many many gigabytes of datas,
>but tiny load) on disks, the cheapest and easiest solution nowdays seems to
>connect large 300 GB IDE disks through USB 2 to a comodity PC.
>
>Now the problem is how to best recover from some disks failure ?

Can you give a bit more detail?  How much data is there?  "many many"
gigabytes can mean a lot.  You say you use DVDs for recovery, but at
~5GB/DVD, that's a LOT of DVDs to store a 5 drive array, especially
since you're talking about 300GB IDE drives.

Can you just use RAID0 then on your backup interval, break the mirror
and store the mirror in the closet, replacing that half of the mirror
with fresh drives?

In theory SATA will support hotplugging and already supports long
cables, so that might be a better solution than external USB
enclosures.

--eric



-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

