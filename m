Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271165AbRHYV1i>; Sat, 25 Aug 2001 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271180AbRHYV12>; Sat, 25 Aug 2001 17:27:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3340 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271165AbRHYV1V>; Sat, 25 Aug 2001 17:27:21 -0400
Subject: Re: unrelated 2.4.x (x=0-9) sound
To: _deepfire@mail.ru
Date: Sat, 25 Aug 2001 22:30:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15akKc-0007KZ-00@f8.mail.ru> from "Samium Gromoff" at Aug 25, 2001 08:47:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15al0s-0008EM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     this time it is not a crash, just a misfeature... ;)
>     i`m used to have the following issue:
>   sound clicks and flakiness while scrolling console
>   text in mc. 

Well there are three causes for this generally

1.	Video cards pulling stupid pranks to get good benchmark results
2.	Chipsets that don't give the ISA bus any useful share of bandwidth
	during AGP or PCI traffic
3.	The console locks

#3 is fixed in -ac
#2 isnt generally fixable but some bioses let you alter the fairness/pci
	rules
#1 normally only appears in X11

