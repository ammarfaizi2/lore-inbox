Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSE3KZy>; Thu, 30 May 2002 06:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316567AbSE3KZx>; Thu, 30 May 2002 06:25:53 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:55795 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316545AbSE3KZw>; Thu, 30 May 2002 06:25:52 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020530064048.GJ19308@atrey.karlin.mff.cuni.cz> 
To: Jan Hubicka <jh@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>,
        Luigi Genoni <kernel@Expansa.sns.it>,
        "J.A. Magallon" <jamagallon@able.es>, Luca Barbieri <ldb@ldb.ods.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1 -march=pentium{-mmx,3,4} 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 May 2002 11:25:14 +0100
Message-ID: <27631.1022754314@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jh@suse.cz said:
>  I don't do that at the moment.  I am thinking about teaching it to
> use SSE moves for moving/clearing 64bit and larger values in memory.
> (ie for inlining constantly sized string operations)

Please ensure that we get -mno-implicit-fp and/or -mno-implicit-sse options 
to GCC _long_ before there's any chance of actually _needing_ to use them 
to get a correct kernel compile.

--
dwmw2


