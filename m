Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132567AbREAUmN>; Tue, 1 May 2001 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136714AbREAUmD>; Tue, 1 May 2001 16:42:03 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:49419 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132567AbREAUl4>; Tue, 1 May 2001 16:41:56 -0400
Subject: Re: iso9660 endianness cleanup patch
To: hpa@transmeta.com (H. Peter Anvin)
Date: Tue, 1 May 2001 21:44:36 +0100 (BST)
Cc: ankry@green.mif.pg.gda.pl (Andrzej Krzysztofowicz),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list), torvalds@transmeta.com,
        Andries.Brouwer@cwi.nl
In-Reply-To: <3AEEFD7F.3E7C6B3@transmeta.com> from "H. Peter Anvin" at May 01, 2001 11:16:31 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14uh0h-0002L1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh bother, you're right of course.  We need some kind of standardized
> macro for indirecting through a potentially unaligned pointer.  It can

get_unaligned()

