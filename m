Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSI3Nln>; Mon, 30 Sep 2002 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbSI3Nln>; Mon, 30 Sep 2002 09:41:43 -0400
Received: from 64-238-252-21.arpa.kmcmail.net ([64.238.252.21]:27039 "EHLO
	kermit.unets.com") by vger.kernel.org with ESMTP id <S262062AbSI3Nlm>;
	Mon, 30 Sep 2002 09:41:42 -0400
Subject: Re: 2.5.39 XConfig Processor Detection
From: Adam Voigt <adam@cryptocomm.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020930133057.GA8868@suse.de>
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
	 <1033389340.16337.14.camel@irongate.swansea.linux.org.uk>
	<20020930.052555.123500588.davem@redhat.com>
	<1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
	<1033392021.1491.6.camel@beowulf.internetstore.com> 
	<20020930133057.GA8868@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Sep 2002 09:48:10 -0400
Message-Id: <1033393690.1487.14.camel@beowulf.internetstore.com>
Mime-Version: 1.0
X-OriginalArrivalTime: 30 Sep 2002 13:47:08.0242 (UTC) FILETIME=[DE7D4320:01C26887]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, that would make sense then. Well I feel kind of dumb, I
just naturally assumed you had a built in feature that read
the /proc for current hardware or something (and since it worked
for me once (when the Athlon was the default)). Heh, well you
learn something new every day.

Adam Voigt
adam.voigt@cryptocomm.com

On Mon, 2002-09-30 at 09:30, Dave Jones wrote:
> On Mon, Sep 30, 2002 at 09:20:21AM -0400, Adam Voigt wrote:
>  > Apologies if this has already been noted or if I'm posting
>  > this to the wrong place/annoying you very busy people needlessly,
>  > but when I run XConfig, in the "Processor Type and Features" tab
>  > it autodetects my processor as a Pentium-4 when in fact it is a
>  > P3 700MHZ. The last time I installed a kernel (2.4.x) by hand, it did
>  > autodetect the processor on that machine (Athlon), so I assume that
>  > feature is still active. Anyways, here's the output from my cpuinfo:
> 
>  There's no 'autodetect' feature.
>  Only defconfig, which sets the default option.
>  These defaults match whatever Linus is currently using, so
>  it seems he upgraded his Athlon box to a P4 8-)
> 
>  Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs


