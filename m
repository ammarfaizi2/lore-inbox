Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRAaSeH>; Wed, 31 Jan 2001 13:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130157AbRAaSdr>; Wed, 31 Jan 2001 13:33:47 -0500
Received: from zurich.ai.mit.edu ([18.43.0.244]:8721 "EHLO zurich.ai.mit.edu")
	by vger.kernel.org with ESMTP id <S130032AbRAaSd0>;
	Wed, 31 Jan 2001 13:33:26 -0500
To: Padraig@antefacto.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <3A7852A9.1060600@AnteFacto.com> (Padraig@AnteFacto.com)
Subject: 2.4.1-pre10 -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
User-Agent: IMAIL/1.9; Edwin/3.105; MIT-Scheme/7.5.13
Message-Id: <E14O247-0002aT-00@qiwi.ai.mit.edu>
From: Chris Hanson <cph@zurich.ai.mit.edu>
Date: Wed, 31 Jan 2001 13:33:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Wed, 31 Jan 2001 18:00:09 +0000
   From: Padraig Brady <Padraig@AnteFacto.com>

   Can we sort this out once and for all? There are a few emails
   everyday relating to this bug.

   The following patch posted by "Troels Walsted Hansen" <troels@thule.no>
   on Jan 11th fixes this. The problem is that when 2 consequtive
   NULLs are sent to klogd it goes into a busy loop. Andrew Mortons
   3c59x driver does this, but also on Jan 11th he replied that he had
   fixed it. I'm using 2.4ac4 with no problems, so I presume some
   of these patches have been lost along the way?

Yes, that did it.  It also explains why my desktop works fine, since
it uses an eepro100 network card.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
