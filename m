Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTFXPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbTFXPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:16:26 -0400
Received: from terminus.zytor.com ([63.209.29.3]:3033 "EHLO terminus.zytor.com")
	by vger.kernel.org with ESMTP id S262494AbTFXPQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:16:25 -0400
Message-ID: <3EF86E50.20504@zytor.com>
Date: Tue, 24 Jun 2003 08:29:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: linux-kernel@vger.kernel.org, John Coffman <johninsd@san.rr.com>
Subject: Re: Kernel & BIOS return differing head/sector geometries
References: <20030624010906.08ad32f3.ktech@wanadoo.es> <20030624013908.B1133@pclin040.win.tue.nl> <bd8hgj$cas$1@cesium.transmeta.com> <20030624012220.E1418@almesberger.net> <3EF7D33E.6060009@zytor.com> <20030624081319.G1326@almesberger.net>
In-Reply-To: <20030624081319.G1326@almesberger.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> H. Peter Anvin wrote:
> 
>>Presumably "linear", not "lba32".  I *presume* LILO has enough 
>>wherewithal to use EBIOS if it's available and fall back to CBIOS 
>>otherwise for at least one of these options.  I at least thought "lba32" 
>>would force EBIOS usage.
> 
> 
> Yes, that seems to be the case. (All the LBA32 code is from John
> Coffman. I've copied him in case he's interested in the thread.)
> But you're still betting on the BIOS to either implement EDD
> correctly, or at least to report that it doesn't support it.
> 
> Call me paranoid, but I wouldn't be at all surprised if there are
> some BIOSes out there that get this wrong.
> 

Well... it's somewhat unlikely given the sheer amount of things that 
would probably break.  The rule these days is that if it works with the 
particular versin of M$ that's currently shipping then it's good, but 
I'm pretty sure NTLOADER uses EDD.

	-hpa


