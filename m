Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315372AbSE2OIp>; Wed, 29 May 2002 10:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSE2OIY>; Wed, 29 May 2002 10:08:24 -0400
Received: from ns.suse.de ([213.95.15.193]:33039 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315372AbSE2OG6>;
	Wed, 29 May 2002 10:06:58 -0400
Date: Wed, 29 May 2002 16:06:58 +0200
From: Dave Jones <davej@suse.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        "J.A. Magallon" <jamagallon@able.es>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
Message-ID: <20020529160658.K27463@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"J.A. Magallon" <jamagallon@able.es>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <20020527145420.GA6738@werewolf.able.es> <1022520676.11859.294.camel@irongate.swansea.linux.org.uk> <20020527215911.GC1848@werewolf.able.es> <20020528012925.GB20729@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2002 at 10:29:25PM -0300, Arnaldo Carvalho de Melo wrote:
 > 	Since you're working on this could I suggest that you use labeled
 > elements, this gccism make the initialization above way more cleaner, safer and
 > easy to read :-) This is being used in the kernel in places like the FSes, the
 > TCP/IP stack and lots of other places.

Patrick Mochel already did it in his reworking of the arch/i386/kernel cruft
It's already merged in my tree, and will hopefully turn up in Linus' tree
sometime soon. So far, it's been dropped (probably because it rejected
when someone else touched something there)

I'll push the resynced version later today

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
