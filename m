Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263745AbRFCTrl>; Sun, 3 Jun 2001 15:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263747AbRFCTrc>; Sun, 3 Jun 2001 15:47:32 -0400
Received: from mail2.ameuro.de ([62.208.90.8]:12046 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id <S263745AbRFCTrL>;
	Sun, 3 Jun 2001 15:47:11 -0400
Message-ID: <3B1A943A.33107832@alarsen.net>
Date: Sun, 03 Jun 2001 21:46:44 +0200
From: Anders Larsen <anders@alarsen.net>
Organization: syst.eng. A.Larsen (http://www.alarsen.net/)
MIME-Version: 1.0
To: mnalis-umsdos@voyager.hr
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: UMSDOS symlink bug
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

last week I got bitten by the UMSDOS symlink bug (symlinks are
created with the last character missing).
After having found and fixed the problem, I located your address
to report it and found that the problem (and the fix!) has been
known for at least half a year.

Although your patches for other problems with UMSDOS may or
may not be ready for Linus yet, the one-liner symlink patch
should IMHO be submitted asap, since it is an obvious fix for
an obvious bug.

Apart from the symlink bug, I haven't seen any of the other
known problems (but now that I have seen your list, I'll try
systematically).

BTW, I create the UMSDOS fs on an ATA flash disk using a 2.4.5
box for use in an embedded system running 2.2.19

cheers
  Anders
-- 
"In theory there is no difference between theory and practice.
 In practice there is." - Yogi Berra
