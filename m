Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313817AbSEEXU6>; Sun, 5 May 2002 19:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313818AbSEEXU6>; Sun, 5 May 2002 19:20:58 -0400
Received: from mnh-1-07.mv.com ([207.22.10.39]:63751 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S313817AbSEEXU5>;
	Sun, 5 May 2002 19:20:57 -0400
Message-Id: <200205060022.TAA03703@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: hugang <gang_hu@soul.com.cn>
cc: glonnon@ridgerun.com, Pavel Machek <pavel@suse.cz>, seasons@fornax.hu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATH] Port software to UML. 
In-Reply-To: Your message of "Sun, 05 May 2002 21:48:19 +0800."
             <20020505214819.19cb9a86.gang_hu@soul.com.cn> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 19:22:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gang_hu@soul.com.cn said:
> Ther problem in bread.

No, the problem is in not understanding UML.

UML's state is somewhat more complicated than the state of a native kernel.

You also need to recreate 
	the host processes
	the ptrace relationships between the tracing thread and the other 
processes
	open file descriptors
	and maybe a few other things that aren't coming to mind

				Jeff

