Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268290AbTCCCVB>; Sun, 2 Mar 2003 21:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268296AbTCCCVB>; Sun, 2 Mar 2003 21:21:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37137 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S268290AbTCCCVA>;
	Sun, 2 Mar 2003 21:21:00 -0500
Message-ID: <3E62BE6E.8010904@pobox.com>
Date: Sun, 02 Mar 2003 21:31:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: nickn <nickn@www0.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BitBucket: GPL-ed *notrademarkhere* clone
References: <Pine.LNX.4.44.0303021651560.17904-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.44.0303021651560.17904-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> I'm a little confused about the on-disk format
> 
> is it SCCS and the problem is that CSSC doesn't recognise everything that
> the latest SCCS does so a patch is needed for CSSC or does it differ
> slightly from SCCS?


CSSC can read the sfiles with the patch posted to lkml, but it cannot 
read the BitKeeper-specific files such as the all-important ChangeSet 
file.  ChangeSet is required to build the DAG that weaves all the sfiles 
together into the proper order.

	Jeff



