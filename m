Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267445AbUIJOx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267445AbUIJOx1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267446AbUIJOx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:53:27 -0400
Received: from www02.ies.inet6.fr ([62.210.153.202]:25749 "EHLO
	smtp.ies.inet6.fr") by vger.kernel.org with ESMTP id S267445AbUIJOxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:53:23 -0400
Message-ID: <4141BFDF.1050200@inet6.fr>
Date: Fri, 10 Sep 2004 16:53:19 +0200
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tglx@linutronix.de
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-IDE <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] sis5513 fix for SiS962 chipset
References: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
In-Reply-To: <1094826555.7868.186.camel@thomas.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Trusted: [ ip=62.210.105.37 rdns=ppp3290-cwdsl.fr.cw.net 
	helo=proxy.inet6-interne.fr by=smtp.ies.inet6.fr ident= ] [ 
	ip=192.168.50.116 rdns=bouton.inet6-interne.fr helo=!192.168.50.116! 
	by=proxy.inet6-interne.fr ident= ]
X-Spam-DCC: dmv.com: web02.inet6.ies 1181; Body=1 Fuz1=1 Fuz2=1
X-Spam-Assassin: No hits=0.2 required=4.5
X-Spam-Untrusted: 
X-Spam-Pyzor: Reported 0 times.
X-Spam-Report: *  0.2 AWL AWL: Auto-whitelist adjustment
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote the following on 09/10/2004 04:29 PM :

>Hi,
>
>1. If the fake 5513 id bit is not set by the BIOS we must have the 5518
>id in the device table.
>
>2. If the register remapping is not set by the BIOS then the enable bit
>check in ide_pci_setup_ports will fail. It's safe to switch to the
>remapping mode here. Keeping the not remapped mode would need quite big
>changes AFAICS.
>  
>

I was worried about these when 5518 was introduced but couldn't test on 
the hardware I had at hand and nobody reported hitting this so it went 
under the carpet. What hardware did you use to test ?

-- 
Lionel Bouton - inet6
---------------------------------------------------------------------
   o              Siege social: 51, rue de Verdun - 92158 Suresnes
  /      _ __ _   Acces Bureaux: 33 rue Benoit Malon - 92150 Suresnes
 / /\  /_  / /_   France
 \/  \/_  / /_/   Tel. +33 (0) 1 41 44 85 36
  Inetsys S.A.    Fax  +33 (0) 1 46 97 20 10
 

