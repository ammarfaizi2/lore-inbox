Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSGIKpY>; Tue, 9 Jul 2002 06:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSGIKpX>; Tue, 9 Jul 2002 06:45:23 -0400
Received: from hell.ascs.muni.cz ([147.251.60.186]:10627 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S313305AbSGIKpX>; Tue, 9 Jul 2002 06:45:23 -0400
Date: Tue, 9 Jul 2002 12:48:08 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Austin Gonyou <austin@digitalroadkill.net>, linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.11+ again?
Message-ID: <20020709124807.D1510@mail.muni.cz>
References: <20020709001137.A1745@mail.muni.cz> <1026167822.16937.5.camel@UberGeek> <20020709005025.B1745@mail.muni.cz> <20020708225816.GA1948@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020708225816.GA1948@werewolf.able.es>; from jamagallon@able.es on Tue, Jul 09, 2002 at 12:58:16AM +0200
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echalon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mosad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2002 at 12:58:16AM +0200, J.A. Magallon wrote:
> Seriously, if you have that kind of problems, take the -aa kernel and use it.
> I use it regularly and it behaves as one would expect, and fast.
> And please, report your results...

I've tried 2.4.19rc1aa2, it swaps even when I have 512MB ram and xcdroast with
scsi-ide emulation cd writer reports to syslog:
Jul  9 12:45:02 hell kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0)
Jul  9 12:45:02 hell kernel: __alloc_pages: 3-order allocation failed
(gfp=0x20/0)
Jul  9 12:45:02 hell kernel: __alloc_pages: 2-order allocation failed
(gfp=0x20/0)
Jul  9 12:45:02 hell kernel: __alloc_pages: 1-order allocation failed
(gfp=0x20/0)
Jul  9 12:45:02 hell kernel: __alloc_pages: 0-order allocation failed
(gfp=0x20/0)

Am I something missing?

-- 
Luká¹ Hejtmánek
