Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRJHS0A>; Mon, 8 Oct 2001 14:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276929AbRJHSZw>; Mon, 8 Oct 2001 14:25:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18960 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S277060AbRJHSZn>; Mon, 8 Oct 2001 14:25:43 -0400
Subject: Re: Whining about NUMA. :)  [Was whining about 2.5...]
To: Martin.Bligh@us.ibm.com
Date: Mon, 8 Oct 2001 19:31:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), landley@trommello.org,
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <1812679136.1002540059@mbligh.des.sequent.com> from "Martin J. Bligh" at Oct 08, 2001 11:20:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15qfBA-0001Rt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The worst possible case I can conceive (in the future architectures 
> that I know of)  is 4 different levels. I don't think the number of access
> speed levels is ever related to the number of processors ?
> (users of other NUMA architectures feel free to slap me at this point).

The classzone code seems to deal in combinations of memory zones, not in
specific zones. It lacks docs and the comments seem at best bogus and
from the old code so I may be wrong.  So its relative weightings for
each combination of memory we might want to consider for each case

Andrea ?

Alan
