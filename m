Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282039AbRKZTGB>; Mon, 26 Nov 2001 14:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282362AbRKZTFh>; Mon, 26 Nov 2001 14:05:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32265 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282039AbRKZTEu>; Mon, 26 Nov 2001 14:04:50 -0500
Message-ID: <3C028ED5.2000109@zytor.com>
Date: Mon, 26 Nov 2001 10:49:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

>>
>>Consistency is a Very Good Thing[TM] (says the one who tries to teach
>>scripts to understand the naming.)  The advantage with the -rc naming is
>>that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
>>-pre-final-really-i-mean-it-this-time phenomenon when the release
>>candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
>>shame in needing more than one release candidate.
>>
> 
> Agreed. I stick with the -rc naming convention for 2.4+... 
> 

I have updated the kernel.org scripts to recognize the -rc naming
convention.  Any -rc patch found is assumed to be newer than any -pre
patch found.

I will try to add tracking of the v2.0 and v2.2 trees sometime later this
week.

	-hpa

