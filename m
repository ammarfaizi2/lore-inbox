Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136392AbRAGS2s>; Sun, 7 Jan 2001 13:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136376AbRAGS2i>; Sun, 7 Jan 2001 13:28:38 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4624 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136343AbRAGS2Y>; Sun, 7 Jan 2001 13:28:24 -0500
Subject: Re: [PATCH] Cyrix III boot fix and bug report
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Sun, 7 Jan 2001 18:29:24 +0000 (GMT)
Cc: hpa@zytor.com (H . Peter Anvin), davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010107201952.C10035@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Jan 07, 2001 08:19:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FKZL-000367-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    3DNOW extensions for Cyrix III via rdmsr from 0x80000001. This
>    fails with an exception, that is not handled and thus we oops
>    on boot.

Interesting. Ok.  We can set the bit unconditionally it seems.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
