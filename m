Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSDQQKe>; Wed, 17 Apr 2002 12:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSDQQKd>; Wed, 17 Apr 2002 12:10:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:4120 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293510AbSDQQKc>;
	Wed, 17 Apr 2002 12:10:32 -0400
Message-ID: <3CBD9063.BF11D4A9@gmx.net>
Date: Wed, 17 Apr 2002 17:10:27 +0200
From: Gunther Mayer <gunther.mayer@gmx.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: traditional bug: only one of two serial ports found on HP Vectra XM
In-Reply-To: <3CBD382B.20432.3A9A82@localhost> <200204171128.g3HBS5X29316@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> On 17 April 2002 04:54, Ulrich Windl wrote:
> > historically I believed Linux very much. When it said my HP Vecra XM
> > only has one serial port I was surprised, but believed it. That was
> > some years ago. 2.4.18 still says that there is one serial port:
> >
> > ttyS00 at 0x3f8 (irq=4) as a 16550A
> >
> > However recently I had to work on the backside of the PC and found
> > two(!) serial ports labelled "Serial A" and "Serial B". So shouldn't
> > both ports be detected?
>
> How about opening the case and checking whether those ports actually
> connected to motherboard? Checking BIOS config?
> Without waiting for another 'some years' :-)
>
> Seriously, do you have any reason to think second port is really
> exists beside physical connector?

If it exists, check if "lspnp" on a PNPBIOS enabled kernel would find your
second port. There have been patches to find BIOS configured serial ports
even if not at standard places.

