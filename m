Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315962AbSEJNki>; Fri, 10 May 2002 09:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315994AbSEJNkh>; Fri, 10 May 2002 09:40:37 -0400
Received: from www.swazicraftsmarket.com ([196.28.7.66]:55507 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S315962AbSEJNkh>; Fri, 10 May 2002 09:40:37 -0400
Date: Fri, 10 May 2002 15:18:15 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] opl3 OSS emulation compile fixes
In-Reply-To: <20020510112819.GA26247@wizard.com>
Message-ID: <Pine.LNX.4.44.0205101516200.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, A Guy Called Tyketto wrote:

>         This is for OPL3 OSS emulation. With your patch applied to 2.5.15, 
> opl3_oss.c was not compiled at all, whether into the kernel, or as a module. 
> Also, your patch for include/sound/opl3.h did not need to be applied as the 
> #ifdef CONFIG_SND_OSSEMUL and #endif lines are already present sound the two 
> variables listed.

For my amusement, could you try loading the opl3 module, i didn't get 
unresolved symbols when i did a depmod. From what i understand of this, 
opl3_oss should not have been compiled indeed unless CONFIG_SND_OSSEMUL 
was specified, although Kysela would know best.

Thanks,
	Zwane

-- 
http://function.linuxpower.ca
		

