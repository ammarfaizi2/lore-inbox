Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSHEChq>; Sun, 4 Aug 2002 22:37:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318289AbSHEChq>; Sun, 4 Aug 2002 22:37:46 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:32136 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S318288AbSHEChq>; Sun, 4 Aug 2002 22:37:46 -0400
Message-Id: <200208050241.g752fBC12491@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, robn@verdi.et.tudelft.nl
Subject: Re: 2.4.19 IDE Partition Check issue 
In-Reply-To: Your message of "04 Aug 2002 19:28:54 BST."
             <1028485734.14196.45.camel@irongate.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 05 Aug 2002 04:41:10 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan wrote:
> The Promise stuff is fixed in -ac and was exactly this issue. LBA48 is
> not supported by the earlier promise controllers. The highpoint may well

Hi Alan,

I planned to do a massive disk replace/relocate action on my machines
soon and part of the plan is having a 160GB Maxtor in some machines.
Got scared by statement above .. :-)

I got myself a 2.4.19-ac3 tree, looked around in the IDE code and wasn't
able to find the answer for my questions:

Any chance of lba48 working on a:

    - Promise Ultra66 (PDC20262: chipset revision 1) ?
    - Intel 82371AB PIIX4 IDE (rev 01) (On P-III BX-chipset mobo) ?
    - Intel 82371FB PIIX IDE [Triton I] (rev 02) (On P-I Triton I mobo) ?

	greetings,
	Rob van Nieuwkerk
