Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290081AbSAKUDJ>; Fri, 11 Jan 2002 15:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290082AbSAKUDA>; Fri, 11 Jan 2002 15:03:00 -0500
Received: from ns.suse.de ([213.95.15.193]:34062 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290081AbSAKUCx>;
	Fri, 11 Jan 2002 15:02:53 -0500
Date: Fri, 11 Jan 2002 21:02:52 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Robert Love <rml@tech9.net>
Cc: Rainer Keller <Keller@hlrs.de>, <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Small optimization for UP in sched and prefetch
In-Reply-To: <1010779162.2139.3.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0201112101290.31366-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jan 2002, Robert Love wrote:

> if we really intend to check for the use of the AMD Athlon as well, we
> need to add CONFIG_MK7, too.  Since the Athlon does have this prefetch,
> it would make sense.  Otherwise, the comment is wrong.

It's handled a few lines further down in a CONFIG_X86_USE_3DNOW
which means that CyrixIII's can also use them too.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

