Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130125AbQKGJi4>; Tue, 7 Nov 2000 04:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130606AbQKGJiq>; Tue, 7 Nov 2000 04:38:46 -0500
Received: from 4dyn176.delft.casema.net ([195.96.105.176]:519 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S130125AbQKGJii>; Tue, 7 Nov 2000 04:38:38 -0500
Message-Id: <200011070938.KAA03419@cave.bitwizard.nl>
Subject: Re: Poor TCP Performance 2.4.0-10 <-> Win98 SE PPP
In-Reply-To: <200011070656.WAA02435@pizda.ninka.net> from "David S. Miller" at
 "Nov 6, 2000 10:56:07 pm"
To: "David S. Miller" <davem@redhat.com>
Date: Tue, 7 Nov 2000 10:38:12 +0100 (MET)
CC: jordy@napster.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> It is clear though, that something is messing with or corrupting the
> packets.  One thing you might try is turning off TCP header
> compression for the PPP link, does this make a difference?

Try specifying "asyncmap 0xffffffff" too. 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
