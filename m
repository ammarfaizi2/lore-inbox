Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271307AbRH1PKt>; Tue, 28 Aug 2001 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271371AbRH1PKj>; Tue, 28 Aug 2001 11:10:39 -0400
Received: from f43.law9.hotmail.com ([64.4.9.43]:48652 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S271307AbRH1PKY>;
	Tue, 28 Aug 2001 11:10:24 -0400
X-Originating-IP: [65.92.114.22]
From: "Camiel Vanderhoeven" <camiel_toronto@hotmail.com>
To: Bart.Vandewoestyne@pandora.be
Cc: linux-kernel@vger.kernel.org
Subject: Re: DOS2linux
Date: Tue, 28 Aug 2001 11:10:36 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F430LDGdyoOxg2elKWQ000009ff@hotmail.com>
X-OriginalArrivalTime: 28 Aug 2001 15:10:36.0348 (UTC) FILETIME=[972517C0:01C12FD3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Vandewoestyne <Bart.Vandewoestyne@pandora.be>
> > Did you do a normal read from memory, or did you use port-i/o?
>
>I used the inb() function.

Sorry for asking, I just wanted to make sure it wasn't something simple...

>My card is at 1000h, that's something i know for sure, because I can
>probe the EISA ID at 0x1000+0xc80.

Good.

> > I'm not very familiar with
> > the EISA architecture, but I do know that each card can use the
> > following I/O ranges:
> > X000h-X0FFh; X400h-X4FFh; X800h-X8FFh; XC00-XCFF, where X is the slot
> > number.
>
>I guess you mean X0000h-X0FFF; X1000-X1FFF; ...

No, I don't. Each EISA slot occupies four 256-byte ranges. That is because 
any address that looks like X100h-X3ffh; X500h-X7ffh etc. is misinterpreted 
by older ISA hardware.

Camiel.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

