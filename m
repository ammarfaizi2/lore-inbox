Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318366AbSIKFSl>; Wed, 11 Sep 2002 01:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIKFS0>; Wed, 11 Sep 2002 01:18:26 -0400
Received: from 212.68.254.82.brutele.be ([212.68.254.82]:56331 "EHLO debian")
	by vger.kernel.org with ESMTP id <S318366AbSIKFQq>;
	Wed, 11 Sep 2002 01:16:46 -0400
Date: Wed, 11 Sep 2002 07:21:33 +0200
From: Stephane Wirtel <stephane.wirtel@belgacom.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: which driver for a Dlink DFE 650TXD (PCMCIA) ?
Message-ID: <20020911052133.GA7848@debian>
References: <20020910080403.GA958@debian> <20020910160930.791c0b61.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20020910160930.791c0b61.kristian.peters@korseby.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: GNU/Linux
X-LUG: Linux Users Group Mons ( Linux-Mons )
X-URL: http://www.linux-mons.be
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! 

Thanks for your response.
I have found my problem. it's a mistake of the debian installation.
it doesn't detect my pcmcia card.

Here my resolution.
	insmod pcmcia_core
	insmod i82365
	insmod ds
	cardmgr -f

now it's working.


thanks 
On Tue, Sep 10, 2002 at 04:09:30PM +0200, Kristian Peters wrote:
> Stephane Wirtel <stephane.wirtel@belgacom.net> schrieb:
> > i haven't found the driver for my pcmcia card.
> > 
> > my kernel is the 2.4.20-pre5-ac4.
> 
> Have you tried pcmcia-cs ? Your card is at least supported there:
> http://pcmcia-cs.sourceforge.net/ftp/SUPPORTED.CARDS
> 
> But afaik the config option "D-Link DE620 pocket adapter support" also supports your card.
> 
> *Kristian
> 
>   :... [snd.science] ...:
>  ::                             _o)
>  :: http://www.korseby.net      /\\
>  :: http://gsmp.sf.net         _\_V
>   :.........................:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Stephane Wirtel <stephane.wirtel@belgacom.net>
Web : www.linux-mons.be	 "Linux Is Not UniX !!!"
OS3B : Club OpenSoftware Carolo : www.os3b.org
