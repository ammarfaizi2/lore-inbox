Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbTE2A5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 20:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbTE2A5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 20:57:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58769 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261788AbTE2A5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 20:57:49 -0400
Message-ID: <3ED55E1E.90004@pobox.com>
Date: Wed, 28 May 2003 21:10:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jason Papadopoulos <jasonp@boo.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-rc3 : IDE pb on Alpha
References: <5.2.1.1.2.20030527211552.00a47190@boo.net> <20030527123152.GA24849@alpha.home.local> <5.2.1.1.2.20030526232835.00a468e0@boo.net> <20030527045302.GA545@alpha.home.local> <20030527134017.B3408@jurassic.park.msu.ru> <20030527123152.GA24849@alpha.home.local> <5.2.1.1.2.20030527211552.00a47190@boo.net> <5.2.1.1.2.20030528203353.02367ec0@boo.net>
In-Reply-To: <5.2.1.1.2.20030528203353.02367ec0@boo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Papadopoulos wrote:
> At 11:12 PM 5/27/03 -0400, Jeff Garzik wrote:
>  >
>  >FWIW, udma2 is the best you can do without accurate cable detection and
>  >an 80-conductor cable.
>  >
> 
> Well, even with a drive capable of ATA66, an 80-pin cable, and a kernel
> configured to force assumption of higher UDMA modes, the best I've ever
> done with this stupid ALI controller is udma2. I think it's deliberately
> crippled.


"configured to force the assumption" does no good if the host controller 
driver isn't detecting the cable correctly, or is not programming 80c 
cable info into the host controller correctly.  That's a code change not 
a configuration thing.

	Jeff



