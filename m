Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289645AbSAXTo2>; Thu, 24 Jan 2002 14:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSAXToS>; Thu, 24 Jan 2002 14:44:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289234AbSAXToI>; Thu, 24 Jan 2002 14:44:08 -0500
Message-ID: <3C5063F4.4050103@zytor.com>
Date: Thu, 24 Jan 2002 11:43:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <3C5047A2.1AB65595@mandrakesoft.com> <a2pn9e$mt5$1@cesium.transmeta.com> <20020124193437.GC23801@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:

> Em Thu, Jan 24, 2002 at 11:28:46AM -0800, H. Peter Anvin escreveu:
> 
>>Noone is actually meant to use _Bool, except perhaps in header files.
>>
>>#include <stdbool.h>
>   
> perhaps we don't need another header, adding this instead to types.h.
> 


That's fine for the Linux kernel, of course, but the above was mostly for
reference -- it's the *intended* way to use these keywords (you have to
explicitly import these macros into the namespace, but using the
C++-compatible tokens is definitely the intention.)

	-hpa


