Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315112AbSDWIpy>; Tue, 23 Apr 2002 04:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315117AbSDWIpx>; Tue, 23 Apr 2002 04:45:53 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54281 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315112AbSDWIpx>; Tue, 23 Apr 2002 04:45:53 -0400
Subject: Re: [SECURITY] FDs 0, 1, 2 for SUID/SGID programs
To: Weimer@CERT.Uni-Stuttgart.DE (Florian Weimer)
Date: Tue, 23 Apr 2002 10:04:20 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87662jiz3b.fsf@CERT.Uni-Stuttgart.DE> from "Florian Weimer" at Apr 22, 2002 04:31:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16zwDk-0008BH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://www.pine.nl/advisories/pine-cert-20020401.html probably affects
> Linux, too (if a SUID/SGID program is invoked with FD 2 closed, error
> messages might be written to a file opened by the program ).

Unix requires this behaviour. Its an old and common bug to get it
wrong. glibc intentionally provides some cover
