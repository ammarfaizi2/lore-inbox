Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281717AbRKVIOu>; Thu, 22 Nov 2001 03:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282069AbRKVIOl>; Thu, 22 Nov 2001 03:14:41 -0500
Received: from frege-d-math-north-g-west.math.ethz.ch ([129.132.145.3]:64425
	"EHLO frege.math.ethz.ch") by vger.kernel.org with ESMTP
	id <S281717AbRKVIOV>; Thu, 22 Nov 2001 03:14:21 -0500
Message-ID: <3BFCF30E.4030605@debian.org>
Date: Thu, 22 Nov 2001 13:43:58 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Asm style
In-Reply-To: <fa.d6k3juv.16q3on@ifi.uio.no> <fa.cbkkrrv.m72ejr@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> There's also:
> 
> 	asm("\
> 	cmd	r,r\n\
> lbl:	cmd	r,r\n\
> 	cmd	r,r\n" : spec : spec);
> 
> 
> Or something similar (the trailing "\" added for continuation). Probably
> the easiest way to patch existing asm.
> 

not ANSI C. The trailing \ is understood only in marco definitions
(and outside strings)

	giacomo



