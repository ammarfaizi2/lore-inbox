Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265327AbSJRWuZ>; Fri, 18 Oct 2002 18:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbSJRWuZ>; Fri, 18 Oct 2002 18:50:25 -0400
Received: from dhcp80ff23a4.dynamic.uiowa.edu ([128.255.35.164]:20620 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S265327AbSJRWuY>;
	Fri, 18 Oct 2002 18:50:24 -0400
Date: Fri, 18 Oct 2002 17:48:35 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: i2c-elektor (2.5.43) non-fatal error: unresolved symbol cli, sti
Message-ID: <20021018224835.GC31649@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't see this, so I'm reporting it:
make -f arch/i386/lib/Makefile modules_install
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.43; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.43/kernel/drivers/i2c/i2c-elektor.o
depmod:         cli
depmod:         sti

Looks like a problem in the i2c-elektor driver.

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
"Alt text doesn't pop up unless you use an ancient browser from the days of
 yore. The relevant standards clearly indicate that it should not, and I
 only know about one browser released in the last two years that violates
 this, and it's still claiming compatibility with Mozilla 4 (which was
 obsolete quite long ago), so it really can't be considered a modern
 browser."  --jonadab, in a slashdot.org comment.
