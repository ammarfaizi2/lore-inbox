Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316158AbSE2Xew>; Wed, 29 May 2002 19:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316163AbSE2Xev>; Wed, 29 May 2002 19:34:51 -0400
Received: from [195.63.194.11] ([195.63.194.11]:41482 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316158AbSE2Xet>; Wed, 29 May 2002 19:34:49 -0400
Message-ID: <3CF557DF.8020005@evision-ventures.com>
Date: Thu, 30 May 2002 00:36:15 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Michail Rusinov <one@da.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: NVidia drivers with 2.5 kernel
In-Reply-To: <281539583.20020529223521@da.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michail Rusinov wrote:
> Hello.
> 
> Is there any method to compile NVidia drivers with linux kernel
> 2.5.18?
> When I begin to compile them, they write
> "error This driver does not support 2.5.x development kernels!"
> Is there any solution to make it work?

Please start by writing a reassembler extension for objdump.
Or just psersuade the nvida people to provide assembler output
files for the parts they would like to preserve closed source.
This would:

1. Still not unveal any information they wan't to disclosure in a trivial
way (the disclosured information would be 100% equivalent.

2. Allow to adjust the code for kernel API changes.

3. They could claim they code it in assembler for performance reasons
and wouldn't therefore get that much unsolicited heat.

