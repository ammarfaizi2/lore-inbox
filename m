Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289042AbSAOLks>; Tue, 15 Jan 2002 06:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289080AbSAOLkj>; Tue, 15 Jan 2002 06:40:39 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:25330 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S289042AbSAOLkW>; Tue, 15 Jan 2002 06:40:22 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020114151942.A20309@thyrsus.com> 
In-Reply-To: <20020114151942.A20309@thyrsus.com>  <20020114132618.G14747@thyrsus.com> <m16QCNJ-000OVeC@amadeus.home.nl> <20020114145035.E17522@thyrsus.com> <20020114142605.A4702@twoflower.internal.do> 
To: esr@thyrsus.com
Cc: Charles Cazabon <linux@discworld.dyndns.org>, linux-kernel@vger.kernel.org,
        arjan@fenrus.demon.nl
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Jan 2002 11:40:05 +0000
Message-ID: <26116.1011094805@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  He hard-compiled in that driver.  lsmod(1) can't see it.

man dmesg.

Others have asserted that this kind of autoconfigure facility for 
non-technical people isn't necessary.

I assert that it is actually harmful, and will make their life more 
difficult.

My father's computer runs Linux. He doesn't need to recompile his kernels 
or do any maintenance - I don't even trust him to run up2date for himself. 
It's all he can manage to dial up and look at a web page so I can grab his 
current IP address out of my logs, log in and do the rest.

If I get a bug report from him, it's not particularly coherent or useful. 
Yet because he has a kernel binary which is identical to the one used by
many other more technical users out there, I can often match what he 
complains about with the more useful bugreports in Bugzilla.

If he (or even I) compiled a custom kernel for him rather than using the 
distro one, I wouldn't have a whelk's chance in a supernova of working out 
WTF he was on about.

--
dwmw2


