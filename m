Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267305AbTABWd2>; Thu, 2 Jan 2003 17:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267307AbTABWd2>; Thu, 2 Jan 2003 17:33:28 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:48317 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267305AbTABWdY>; Thu, 2 Jan 2003 17:33:24 -0500
Message-ID: <3E14BFD4.7000909@google.com>
Date: Thu, 02 Jan 2003 14:40:20 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lionel Bouton <Lionel.Bouton@inet6.fr>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
       Teodor Iacob <Teodor.Iacob@astral.kappa.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDMA 133 on a 40 pin cable
References: <20030102182932.GA27340@linux.kappa.ro> <1041536269.24901.47.camel@irongate.swansea.linux.org.uk> <3E14B698.8030107@inet6.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> #1 How is the 40/80 pin detection done at the hardware level ?


On the motherboard end of the 80 conductor cable, the connector shorts 
one of the pins to ground (maybe pin 38).  The ide controller  just 
checks to see if the pin is pulled low or not.  Pulled low = 80 pin. 
 That's one of the reasons it's important to plug IDE cables in the 
correct way.

    Ross


