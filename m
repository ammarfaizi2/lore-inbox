Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRLBQW6>; Sun, 2 Dec 2001 11:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280805AbRLBQWs>; Sun, 2 Dec 2001 11:22:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18449 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280190AbRLBQWi>; Sun, 2 Dec 2001 11:22:38 -0500
Subject: Re: Coding style - a non-issue
To: stano@meduna.org (Stanislav Meduna)
Date: Sun, 2 Dec 2001 16:31:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112020801.fB281Wt07893@meduna.org> from "Stanislav Meduna" at Dec 02, 2001 09:01:32 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16AZWZ-0003ml-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The need of the VM change is probably a classical example -
> why was it not clear at the 2.4.0-pre1, that the current
> implementation is broken to the point of no repair? I am

Because nobody had run good test sets by then - anyway it was repairable.
Linus kept ignoring, refusing and merging conflicting patches. The -ac tree
since 2.4.9-ac or so with Rik's actual fixes he wanted Linus to takes passes
the Red Hat test suite. 2.4.16 kind of passes it now. 

It had nothing to do with the VM being broken and everything to do with
what Linus applied. As it happens it looks like the new VM is better
performing for low loads which is good, but the whole VM mess wasn't bad QA
and wasn't bad design.

Linus was even ignoring patches that fixed comments in the VM code that
referenced old behaviour. And due to the complete lack of VM documentation
at the moment I can only assume he's been dropping Andrea's VM comments/docs 
too.

Alan
