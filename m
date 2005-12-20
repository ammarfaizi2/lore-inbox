Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVLTOfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVLTOfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 09:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVLTOfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 09:35:53 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:3853 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S1751068AbVLTOfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 09:35:53 -0500
In-Reply-To: <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de> <20051217205238.GR23349@stusta.de> <61D4A300-4967-4DC1-AD2C-765A3D2D9743@comcast.net> <20051218054323.GF23384@wotan.suse.de> <5DB2F520-5666-4C7F-9065-51117A0F54B9@comcast.net> <43A694DF.8040209@aitel.hist.no> <A3567036-A5F9-4CF9-BC48-70CFEAA8F2C4@comcast.net> <1135014201.10933.4.camel@localhost> <B1D5AEA1-A120-4997-AD9A-A2379B6A1779@comcast.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C97741F0-5EF9-4845-893A-35BD6ACD849B@oxley.org>
Cc: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, Kyle Moffett <mrmacman_g4@mac.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Content-Transfer-Encoding: 7bit
From: Felix Oxley <lkml@oxley.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Tue, 20 Dec 2005 14:35:48 +0000
To: Parag Warudkar <kernel-stuff@comcast.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Dec 2005, at 19:10, Parag Warudkar wrote:

>
> No one is answering what are we gaining from removing the 8K stack  
> "_option_" - few bytes of code size, reason to not fix the VM, for  
> fun, for screwing over? Why not let people choose 8K if they need it?

The proposed patch is for mm only. What you are gaining is wider  
testing of 4K stacks.

I am just a lurker but, having read the entire thread, it seems to me  
that:
1) the patch should be applied to mm.
2) ndiswrapper should be modified to work with 4K stacks.

It seems unlikely to me that this patch will be pushed to Linus just  
because it has been in mm.
If that possibility comes up in 6-12 months then the flamewar can  
begin again.

regards,
Felix
  
