Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282838AbRK0HRc>; Tue, 27 Nov 2001 02:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282836AbRK0HRX>; Tue, 27 Nov 2001 02:17:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7175 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282833AbRK0HRO>; Tue, 27 Nov 2001 02:17:14 -0500
Message-ID: <3C033DDE.5090400@zytor.com>
Date: Mon, 26 Nov 2001 23:16:46 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Nathan Myers <ncm-nospam@cantrip.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] omnibus header cleanup, certification
In-Reply-To: <20011127061714.A41881@cantrip.org> <3C03315C.5060203@zytor.com> <20011127071420.A45036@cantrip.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Myers wrote:

> 
> Not true, in principle.  E.g.
> 
>   #define foo -1
>   ...
>   char f(char* a) { return foo[a]; }  // -a[1] or a[-1]?
> 
> Such an expression should, of course, be taken out and shot (although
> it's far less bad than "(x = x++ % y)" that appeared in a macro until
> very recently).  
> 


OK, you win :)

	-=hpa

