Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319272AbSHNThb>; Wed, 14 Aug 2002 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319273AbSHNThb>; Wed, 14 Aug 2002 15:37:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:528 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319272AbSHNThb>; Wed, 14 Aug 2002 15:37:31 -0400
Message-ID: <3D5AB250.3070104@zytor.com>
Date: Wed, 14 Aug 2002 12:41:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com> <20020814194019.A31761@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
>>
>>Bullsh*t.  It can legitimately transform it into:
>>
>>	   i = N;
> 
> 
> Right! But people are confusing "practise", "published interface", and 
> "spec" again. 
> 
> Published interface in this case is that gcc will not optimize an empty
> loop away, as it is often used to generate a timing loop. 
> 

Yes.  This is a gcc-specific wart, a bad idea from the start, and 
apparently one which has caught up with them to the point that they've 
had to abandon it.

	-hpa


