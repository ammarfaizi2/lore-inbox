Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSFXMXZ>; Mon, 24 Jun 2002 08:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313087AbSFXMXY>; Mon, 24 Jun 2002 08:23:24 -0400
Received: from cwbone.bsi.com.br ([200.194.240.1]:1128 "EHLO cwbone.bsi.com.br")
	by vger.kernel.org with ESMTP id <S313060AbSFXMXX>;
	Mon, 24 Jun 2002 08:23:23 -0400
Message-ID: <3D170F37.7000900@PolesApart.dhs.org>
Date: Mon, 24 Jun 2002 09:23:19 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Markus Schoder <markus_schoder@yahoo.de>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
References: <200206231945.27717.markus_schoder@yahoo.de>
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Schoder wrote:

>Hi Alexandre,
>
>you are using the proprietary nVidia module (NVdriver), so you would have
>to address any kernel problems to nVidia since they are the ones who have the
>source.
>
>However lots of people (including myself) have seen the same problem when 
>using the nVidia module.  For me it went away when upgrading to the 1.0-2960 
>drivers.  If you haven't done so yet this would be the first thing to try.
>
>Hope this helps,
>Markus
>
>  
>
I'm already using the 1.0-2960 version, and that's the version in the 
report. It's possible that the NVdriver module is the cause of the 
problem, but the bug spots in kernel's vm, in a place which it's no 
supposed to, at the point I understand. So, or the module does something 
very ugly, or the kernel really have a bug, or yet it's nothing related 
to the nvdriver. Unfortunately, the backtrace don't help me figuring 
that out, since I'm no vm expert, but perhaps someone will. I may 
attempt to forward this to Nvidia folks, but reporting a bug which only 
spotted once and in a "pre" series kernel may hurt their feelings...

Thanks,

Alexandre


