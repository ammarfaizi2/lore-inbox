Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRLGO5Y>; Fri, 7 Dec 2001 09:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281795AbRLGO5S>; Fri, 7 Dec 2001 09:57:18 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:45835 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S281780AbRLGOzC>; Fri, 7 Dec 2001 09:55:02 -0500
Message-ID: <3C10D83E.81261D74@delusion.de>
Date: Fri, 07 Dec 2001 15:54:54 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: release() locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

According to Linus' 2.5.1-pre changelog, the release locking changes
introduced in -pre5 are your work. Those changes, however, seem to
break the keyboard driver:

keyboard: Timeout - AT keyboard not present?(f4)

Other people (i.e. Mike Galbraith) have been experiencing the same.

Do you have an updated patch which fixes those issues? -pre6 still
contains the same stuff as -pre5 and if it's broken then Linus should
probably back it out.

Regards,
Udo.
