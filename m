Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSEYVvt>; Sat, 25 May 2002 17:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEYVvs>; Sat, 25 May 2002 17:51:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15366 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315416AbSEYVvs>; Sat, 25 May 2002 17:51:48 -0400
Message-ID: <3CF0075A.6030906@zytor.com>
Date: Sat, 25 May 2002 14:51:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020524
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: isofs unhide option:  troubles with Wine
In-Reply-To: <1022301029.2443.28.camel@jwhiteh> <acopak$1th$1@penguin.transmeta.com> <acosbi$2lr$1@cesium.transmeta.com> <20020525232044.B18560@bouton.inet6-interne.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:
> On Sat, May 25, 2002 at 01:31:46PM -0700, H. Peter Anvin wrote:
> 
>>[...]
>>I think we should just dump the hidden bit; if someone wants it they
>>can ioctl() for it.
>>
> 
> 
> I didn't know we could and couldn't find how from a quick look-through in
> fs/. Is the ioctl really implemented ? If so where should I look ?
> That would be good news for Wine as they would have a way to populate the
> flags member of the struct.
> 

I don't think it's there now.  We should add it, though.

	-hpa


