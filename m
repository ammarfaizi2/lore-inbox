Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131114AbQKGKQY>; Tue, 7 Nov 2000 05:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131193AbQKGKQO>; Tue, 7 Nov 2000 05:16:14 -0500
Received: from pizda.ninka.net ([216.101.162.242]:41860 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131114AbQKGKPy>;
	Tue, 7 Nov 2000 05:15:54 -0500
Date: Tue, 7 Nov 2000 02:00:51 -0800
Message-Id: <200011071000.CAA03188@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: R.E.Wolff@BitWizard.nl
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
In-Reply-To: <200011070935.KAA03412@cave.bitwizard.nl>
	(R.E.Wolff@BitWizard.nl)
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <200011070935.KAA03412@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Tue, 7 Nov 2000 10:35:21 +0100 (MET)
   From: R.E.Wolff@BitWizard.nl (Rogier Wolff)

   This smells of "wrong checksums getting generated", in my opinion.

Actually the current hypothesis is that the checksums are incorrect,
but only because something between Linux and win98 are changing the
TCP sequence numbers in the packet but not updating the checksum to
match.

Jordan, if you check the windows registry or wherever you view SNMP
statistics under win98, do the "TCP checksum" or "TCP discard" error
counters change after one of these "slow" PPP sessions to
2.4.0-test10?

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
