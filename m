Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbSKYS0w>; Mon, 25 Nov 2002 13:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbSKYS0w>; Mon, 25 Nov 2002 13:26:52 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:57021 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S262712AbSKYS0v>; Mon, 25 Nov 2002 13:26:51 -0500
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
Organization: INFN
To: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: e7500 and IRQ assignment
Date: Mon, 25 Nov 2002 19:34:47 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com> <200211251618.28510.gabrielli@roma2.infn.it> <Pine.LNX.4.50.0211251038280.1462-100000@montezuma.mastecende.com>
In-Reply-To: <Pine.LNX.4.50.0211251038280.1462-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200211251934.47959.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:41, lunedì 25 novembre 2002, Zwane Mwaikambo wrote:
> On Mon, 25 Nov 2002, Emiliano Gabrielli wrote:
> > number of MP IRQ sources: 20.
> > number of IO-APIC #2 registers: 24.
> > number of IO-APIC #3 registers: 24.
> > number of IO-APIC #4 registers: 24.
> > number of IO-APIC #5 registers: 24.
> > number of IO-APIC #6 registers: 24.
> > testing the IO APIC.......................
>
> Out of curiosity, does this box really have 5 IOAPICs?
>
> 	Zwane

no of course, but something seems to be buggy...

..  nothing changed ;((

I have patched last 2.4.20-rc3 with Ingo patch (irqsharing.patch) or/and 
apic_route-2.4.18.patch ... patch applies with no problems but no change...

I have downloaded the prepatched kernel from www.aslab.com (linux-2.4.19-1)
(they affirm their servers use 7500) and even in this case no change 
appened...

I have HT enabled in the BIOS; SMP and IO-APIC are compiled in the kernel...

but I still receive some buggy messages in dmesg (see attachement), btw my 
full custom device has IRQ routed to 0 (see my lspci)

If anybody as some IDEA ... I will happy ;P

best regards,

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

