Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287955AbSABUtz>; Wed, 2 Jan 2002 15:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287968AbSABUtm>; Wed, 2 Jan 2002 15:49:42 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37133 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287955AbSABUsi>; Wed, 2 Jan 2002 15:48:38 -0500
Subject: Re: ISA slot detection on PCI systems?
To: esr@thyrsus.com
Date: Wed, 2 Jan 2002 20:59:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel List)
In-Reply-To: <20020102151539.A14925@thyrsus.com> from "Eric S. Raymond" at Jan 02, 2002 03:15:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LsU0-0005RB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any way to safely probe a PCI motherboard to determine whether
> or not it has ISA cards present, or ISA card slots?

You can make an educated guess. However it is at best an educated guess.
The DMI tables will tell you what PCI and ISA slots are present (but
tend to be unreliable on older boxes).  You can also look for an ISA bridge
in lspci as a second source of information.

