Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267770AbTADBUn>; Fri, 3 Jan 2003 20:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbTADBUm>; Fri, 3 Jan 2003 20:20:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267770AbTADBTb>;
	Fri, 3 Jan 2003 20:19:31 -0500
Message-ID: <3E163869.5040209@pobox.com>
Date: Fri, 03 Jan 2003 20:27:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: Re: [BK PATCHES] net driver merges
References: <20030104000211.GA32508@gtf.org>
In-Reply-To: <20030104000211.GA32508@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> More to come, this is just today's batch :)
> 
> The crc32 cset fixes an ugly bug that's been there since crc32 was
> originally merged.  I guess nobody uses multicast, because nearly every
> net driver's multicast was broken due to broken ether_crc() function
> until right now.  Good spotting on Manfred's part.

A quick credits correction, since I omitted this in the commit:  Manfred 
did the crc32 patch as well as spotting the bug.  That wasn't clear from 
the cset comment nor my comment quoted above...

