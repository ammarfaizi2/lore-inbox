Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbRAIKXB>; Tue, 9 Jan 2001 05:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130792AbRAIKWv>; Tue, 9 Jan 2001 05:22:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:43018 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129880AbRAIKWd>; Tue, 9 Jan 2001 05:22:33 -0500
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
To: middelink@polyware.nl (Pauline Middelink)
Date: Tue, 9 Jan 2001 10:23:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org,
        acme@conectiva.com.br (Arnaldo Carvalho de Melo), linux@advansys.com,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <20010109083007.A24914@polyware.nl> from "Pauline Middelink" at Jan 09, 2001 08:30:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FvwT-0006ML-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >      save_flags(flags);
> >      cli();
> > @@ -9965,7 +9972,7 @@
> >  }
> 
> Err, according tho wise ppl on this list, this does not work on
> MIPSes. The flags thing must stay in the same stackframe.

Certainly doesnt work on sparc32, but then it didnt before. Inline it might
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
