Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312525AbSCUWCX>; Thu, 21 Mar 2002 17:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312526AbSCUWCO>; Thu, 21 Mar 2002 17:02:14 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14352 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312525AbSCUWB5>; Thu, 21 Mar 2002 17:01:57 -0500
Subject: Re: [PATCH] zlib double-free bug
To: trini@kernel.crashing.org (Tom Rini)
Date: Thu, 21 Mar 2002 22:13:27 +0000 (GMT)
Cc: hpa@zytor.com (H. Peter Anvin), linux-kernel@vger.kernel.org
In-Reply-To: <20020321210356.GI25237@opus.bloom.county> from "Tom Rini" at Mar 21, 2002 02:03:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16oAoJ-0006RH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's getting there.  The 'issue' is that the best way to fix it (maybe
> 2.4.20-pre1 even) is to backport the 2.5 zlib which doesn't have this

2.4.19ac has the shared zlib already. The zlib sharing stuff wasnt a 2.5
patch backported - its a 2.4 fix that went forward
