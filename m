Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129141AbRBKCNh>; Sat, 10 Feb 2001 21:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129030AbRBKCN2>; Sat, 10 Feb 2001 21:13:28 -0500
Received: from mail49-s.fg.online.no ([148.122.161.49]:15796 "EHLO
	mail49.fg.online.no") by vger.kernel.org with ESMTP
	id <S129141AbRBKCNX>; Sat, 10 Feb 2001 21:13:23 -0500
Message-ID: <6900629.981857587481.JavaMail.webmail1@wm-java2.fg.online.no>
Date: Sun, 11 Feb 2001 03:13:07 +0100 (CET)
From: Ole Andre Vadla Ravnaas <oleavr@online.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.2-pre3 and 2.4.1-ac9 sound corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14RfgE-00029m-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17059273.981857587476.JavaMail.webmail1@wm-java2.fg.online.no"
X-Mailer: Online Epostleser
X-Real-User: oleavr
X-Client-Addr: 62.66.242.169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--17059273.981857587476.JavaMail.webmail1@wm-java2.fg.online.no
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: quoted-printable

> Are you using XFree86 4.0 on a matrox card ?

No, it's an nVIDIA Riva TNT2 Ultra 32 MB AGP (card manufacturer: Creative).=
 But these problems are not related to X, as they are the same whether I us=
e mpg123 in a plain console or xmms in X. But, I've also tried something el=
se, I compiled a kernel with absolutely NO sound support, then downloaded O=
SS from www.opensound.com and installed it. The exact _same_ problems occur=
ed. So now I'm suspecting the IRQ-sharing with the two USB UHCI-controllers=
 to be the problem (worked fine with 2.4.1 "vanilla" though, where the same=
 devices were sharing the same interrupts..). Have there been any changes o=
n that part? (USB UHCI driver IRQ-sharing etc.)

(Please CC a copy to me as I'm not subscribed to the linux kernel mailing-l=
ist right now)

Regards
Ole Andr=E9 Vadla Ravn=E5s

--17059273.981857587476.JavaMail.webmail1@wm-java2.fg.online.no--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
