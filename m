Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbVLSURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbVLSURW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVLSURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:17:22 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:14725 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S964940AbVLSURV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:17:21 -0500
In-Reply-To: <1135020446.10933.8.camel@localhost>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <43A694DF.8040209@aitel.hist.no> <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net> <1135014201.10933.4.camel@localhost> <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net> <1135020446.10933.8.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D5AD0C5C-CB2C-43AF-913E-23C1FFB1A50C@comcast.net>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 19 Dec 2005 15:17:14 -0500
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 19, 2005, at 2:27 PM, Dumitru Ciobarcianu wrote:

> but you din't answered my question
> regarding _which_ os you mentioned needing more stack space and why.

The two other commercially successful OSes - Windows and Solaris have  
12Kb and 8Kb default kernel stack sizes. And both seem to do well  
(hold on :) with the large stack sizes - meaning there is no  
commercially observed problem created by the 8K stack size. Solaris  
even lets you change the kernel stack size at runtime.

Even if we keep aside the impending argument about both OS'es being  
crap and we shouldn't be imitating them, we could still derive one  
conclusion from them - it is possible to have larger stack on i386  
without problems (albeit with some drawbacks) which could be used  
under certain circumstances.

Parag
