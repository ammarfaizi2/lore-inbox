Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSHJKoh>; Sat, 10 Aug 2002 06:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316789AbSHJKoh>; Sat, 10 Aug 2002 06:44:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7945 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316788AbSHJKoh>; Sat, 10 Aug 2002 06:44:37 -0400
Message-ID: <3D54EF69.5060709@zytor.com>
Date: Sat, 10 Aug 2002 03:48:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org> <20020810114003.A5459@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Aug 10, 2002 at 01:27:36AM +0300, Matti Aarnio wrote:
> 
>>  How NetBSD handles the issue, I don't know.   One interpretation
>>  of what you say is that when a new architecture is added to NetBSD,
>>  it will instantly inherit the entire historical set of syscalls,
>>  including the obsolete ones.
> 
> netbsd puts all syscall code not needed by the current release under a
> per-version ifdef.  A new port starting at, say 1.4, will never have
> this enabled (unless it has binary emulations that need parts of the
> old syscalls)

Sure, but that still means the *current* ABI is consistent between 
platforms.

	-hpa

