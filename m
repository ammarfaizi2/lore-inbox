Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbTDBHLP>; Wed, 2 Apr 2003 02:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTDBHLP>; Wed, 2 Apr 2003 02:11:15 -0500
Received: from terminus.zytor.com ([63.209.29.3]:4272 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id <S261958AbTDBHLO>;
	Wed, 2 Apr 2003 02:11:14 -0500
Message-ID: <3E8A8FB5.5050201@zytor.com>
Date: Tue, 01 Apr 2003 23:22:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
References: <UTC200303272027.h2RKRbf27546.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0303311039190.5042-100000@serv> <20030331172403.GM32000@ca-server1.us.oracle.com> <1049208134.19703.12.camel@dhcp22.swansea.linux.org.uk> <b6d23r$ihn$1@cesium.transmeta.com> <20030402081243.A22213@infradead.org>
In-Reply-To: <20030402081243.A22213@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> For block devices this is no problem, they register regions not majors.
> For character devices that sounds the way to go, too.  I'll look into it
> once I've finished by devfs API sanitizing, but if viro magically reappeared
> and could post his existing patches for it this would make it even easier...
 >

Personally I think it's needless complexity (workaround for a too-small 
address space which is better fixed by making the address space larger), 
but it does allow for more flexibility and assuming it doesn't come with 
unacceptable overhead I guess it doesn't hurt.

	-hpa

