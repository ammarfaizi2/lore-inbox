Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbRFMVlD>; Wed, 13 Jun 2001 17:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263886AbRFMVkx>; Wed, 13 Jun 2001 17:40:53 -0400
Received: from pille1.addcom.de ([62.96.128.35]:2061 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S263469AbRFMVkh>;
	Wed, 13 Jun 2001 17:40:37 -0400
Date: Wed, 13 Jun 2001 23:40:20 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Boenisch Joerg <joerg.boenisch@siemens.at>
cc: "Linux-Kernel (E-Mail)" <linux-kernel@vger.kernel.org>
Subject: Re: AVM A1 pcmcia, kernel 2.4.5-ac11 problem
In-Reply-To: <D9F2B9CD7BD5D21196BC0800060D9ED604ED6344@vies186a.sie.siemens.at>
Message-ID: <Pine.LNX.4.33.0106122220100.25810-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2001, Boenisch Joerg wrote:

> I hope not to be off topic! (In that case could you tell me where to ask?)

You can try isdn4linux@listserv.isdn4linux.de or the newsgroup 
de.alt.comm.isdn4linux.de, but I can't guarantee success there, either.

> Kernel of course is compiled with ISDN support and low-level AVM-A1-PCMCIA.
> After installation in /lib/modules hisax.o can be found, but not avma1_cs.o

> cardmgr[1070]: module /lib/modules/2.4.5-ac11/pcmcia/avma1_cs.o not
> available

The problem is obviously that you're lacking the avma1_cs.o module. I 
believe it was distributed separately and not included in the kernel tree 
/ pcmcia-cs. If you want to go look for it, try linux-pcmcia on 
sourceforge.net, or your favorite web search engine.

If you dig it up somewhere and get it working with 2.4.5, it would be nice 
if you let me know. We can then work together to integrate it into the 
kernel tree - I can't do it myself, because I don't have the card.

--Kai



