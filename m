Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSA2Pgz>; Tue, 29 Jan 2002 10:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289728AbSA2Pgn>; Tue, 29 Jan 2002 10:36:43 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63492 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289715AbSA2PgA>; Tue, 29 Jan 2002 10:36:00 -0500
Subject: Re: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
To: Sebastien.Cabaniols@Compaq.com (Cabaniols, Sebastien)
Date: Tue, 29 Jan 2002 15:48:18 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), velco@fadata.bg (Momchil Velikov),
        helgehaf@aitel.hist.no (Helge Hafting), linux-kernel@vger.kernel.org
In-Reply-To: <11EB52F86530894F98FFB1E21F9972540C239D@aeoexc01.emea.cpqcorp.net> from "Cabaniols, Sebastien" at Jan 29, 2002 04:27:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VaUc-0004IZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> and after having insmoded the page coloring module with verbosity at
> maximum,I can see only 8 pages 
> allocated and coloured by the system and then nothing. The processes are
> forked
> and eat the memory (doing their job as they should) bypassing my patch
> (as if it was not present), 
> that's why I suspect another mecanism is used. Am I wrong ?

As I said, its done by the page fault handler. 
