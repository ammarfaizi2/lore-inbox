Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262220AbSIZHLs>; Thu, 26 Sep 2002 03:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262221AbSIZHLs>; Thu, 26 Sep 2002 03:11:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262220AbSIZHLr>;
	Thu, 26 Sep 2002 03:11:47 -0400
Message-ID: <3D92B450.2090805@pobox.com>
Date: Thu, 26 Sep 2002 03:16:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: wli@holomorphy.com, axboe@suse.de, akpm@digeo.com,
       linux-kernel@vger.kernel.org, patman@us.ibm.com, andmike@us.ibm.com
Subject: Re: [PATCH] deadline io scheduler
References: <20020926064455.GC12862@suse.de>	<20020926065951.GD12862@suse.de>	<20020926070615.GX22942@holomorphy.com> <20020926.000620.27781675.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: William Lee Irwin III <wli@holomorphy.com>
>    Date: Thu, 26 Sep 2002 00:06:15 -0700
>    
>    Hmm, qlogicisp.c isn't really usable because the disks are too
>    slow, it needs bounce buffering, and nobody will touch the driver
> 
> I think it's high time to blow away qlogic{fc,isp}.c and put
> Matt Jacob's qlogic stuff into 2.5.x


Seconded.  Thanks for remembering that name.

Has his stuff been cleaned up, code-wise, in the past few years?  My 
experience with it was 100% positive from a technical standpoint, but 
negative from a style standpoint...

	Jeff, volunteering to test the QL-ISP



