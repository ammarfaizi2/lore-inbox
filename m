Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSFOPZR>; Sat, 15 Jun 2002 11:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315424AbSFOPZQ>; Sat, 15 Jun 2002 11:25:16 -0400
Received: from [64.76.155.18] ([64.76.155.18]:49079 "EHLO alumno.inacap.cl")
	by vger.kernel.org with ESMTP id <S315421AbSFOPZQ>;
	Sat, 15 Jun 2002 11:25:16 -0400
Date: Sat, 15 Jun 2002 11:18:24 -0400 (CLT)
From: Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][TRIVIAL] Print a KERN_INFO after a module gets loaded 
In-Reply-To: <Pine.LNX.4.44.0206151007420.30400-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0206151110140.5254-100000@alumno.inacap.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Zwane Mwaikambo wrote:
> 
> And when this gets to mainline, what stops your hacker from removing the 
> printk from displaying? The way i see it, if the person is loading modules 
> you're screwed beyond help.
> 

That's why I was asking for a better place to put this printk, maybe the 
correct one is just _before_ the module register its "features", you can 
always check `dmesg` for a list of loaded modules, but again, if I put the 
printk before the module correctly registers I can get some fake "loaded" 
messages, from modules that did not complete the registration. I'll review 
more carefully the loading process, perhaps adding the module address, or 
even its path, I'll give it a look after giving class today, I'm already 
late 8-)

Best regards.
-- 
Robinson Maureira Castillo
Asesor DAI
INACAP

