Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312590AbSG2Hr6>; Mon, 29 Jul 2002 03:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSG2Hr6>; Mon, 29 Jul 2002 03:47:58 -0400
Received: from [196.26.86.1] ([196.26.86.1]:12965 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312590AbSG2Hr6>; Mon, 29 Jul 2002 03:47:58 -0400
Date: Mon, 29 Jul 2002 10:08:52 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.29 sound/oss/trident.c [2/2] remove cli/sti calls
In-Reply-To: <20020728202207.GB10499@alhambra.actcom.co.il>
Message-ID: <Pine.LNX.4.44.0207290948110.20701-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jul 2002, Muli Ben-Yehuda wrote:

> +
> +	spin_unlock_irqrestore(&card->lock, flags); 
>  	
>  	restore_flags(flags);
>  }

hmm...

-- 
function.linuxpower.ca


