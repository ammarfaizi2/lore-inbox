Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSILVve>; Thu, 12 Sep 2002 17:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSILVve>; Thu, 12 Sep 2002 17:51:34 -0400
Received: from pD9E23F87.dip.t-dialin.net ([217.226.63.135]:6120 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S315198AbSILVvd>; Thu, 12 Sep 2002 17:51:33 -0400
Date: Thu, 12 Sep 2002 15:56:19 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Sibley <jlsibley@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Giuliano Pochini <pochini@shiny.it>, <riel@conectiva.com.br>
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <200209121619.53111.pollard@admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.44.0209121551310.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Sep 2002, Jesse Pollard wrote:
> ulimit is a per login limit, not a global per user limit.

I see... Wonderous that I've forgot that.

> Now, which of these processes should be killed?

...the last of the user who has the most processes?

I still don't think that a whitelist could be that good. And however, it 
doesn't stand against my suggestion. Firstly kill processes which likely 
deadloop on malloc, then the unlisted, and then the rest. All under the 
cover of overcommitment...

...Linux, the best-tinkered OOM-killing operating system...

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

