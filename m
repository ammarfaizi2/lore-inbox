Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277576AbRJRDZr>; Wed, 17 Oct 2001 23:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277578AbRJRDZi>; Wed, 17 Oct 2001 23:25:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14867 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277576AbRJRDZf>; Wed, 17 Oct 2001 23:25:35 -0400
Message-ID: <3BCE4BB5.8060603@zytor.com>
Date: Wed, 17 Oct 2001 20:25:41 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en, sv
MIME-Version: 1.0
To: paulus@samba.org
CC: linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com>	<3BCBE29D.CFEC1F05@alacritech.com>	<9qjfki$ob5$1@cesium.transmeta.com> <15310.18125.367838.562789@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> 
> PPP uses a variant of zlib with some extensions.  I believe that I
> didn't break zlib for normal use when I added the extensions but I
> would have to check that to be 100% sure.  The PPP zlib.c is based on
> zlib-1.0.4, which is no longer the most recent version.
> 


What kind of extensions?


> I think it would be possible to make PPP use the standard zlib but
> with decreased performance.  It's a long time since I looked at that
> stuff though.

 >

>>A major problem is that the module name "deflate" is used by PPP,
>>despite it being a nonstandard format...
>>
> 
> No, the module name is "ppp_deflate".
> 


Oh.  Well, then ...

	-hpa


