Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275863AbRJBIsC>; Tue, 2 Oct 2001 04:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJBIrw>; Tue, 2 Oct 2001 04:47:52 -0400
Received: from web20505.mail.yahoo.com ([216.136.226.140]:64008 "HELO
	web20505.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S275863AbRJBIrj>; Tue, 2 Oct 2001 04:47:39 -0400
Message-ID: <20011002084807.3579.qmail@web20505.mail.yahoo.com>
Date: Tue, 2 Oct 2001 10:48:06 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: [PATCH] Stateful Magic Sysrq Key
To: Ian Stirling <root@mauve.demon.co.uk>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest either making this behaviour optional,
or making it
> so that hitting alt-sysrq twice, without any other
keys being
> pressed makes the next key stick.

I agree with you that there's a risk. Mike Harris had
written a
patch for 2.2 which did something similar, but
slightly better 
IMO since it avoids risks of mis-press, handles
correctly
broken keyboards and keeps compatible with the
existing 
method. Basically, it allows the user to press Alt,
then SysRQ,
release SysRQ then press the desired key, and later
release
Alt. In fact, it only resets the "magic-key-mode" flag
after Alt
has been released, and doesn't bother when SysRq is
released.

I don't remember where it was available, but if
someone needs
it, I still have it here for 2.2.

Willy


___________________________________________________________
Do You Yahoo!? -- Un e-mail gratuit @yahoo.fr !
Yahoo! Courrier : http://fr.mail.yahoo.com
