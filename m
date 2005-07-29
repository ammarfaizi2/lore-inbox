Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbVG2EKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbVG2EKn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 00:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVG2EKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 00:10:42 -0400
Received: from washoe.rutgers.edu ([165.230.95.67]:50076 "EHLO
	washoe.rutgers.edu") by vger.kernel.org with ESMTP id S262304AbVG2EKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 00:10:40 -0400
Date: Fri, 29 Jul 2005 00:10:32 -0400
From: Yaroslav Halchenko <kernel@onerussian.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.8 -> 2.6.11 (+ata-dev patch) -- HDD is always on
Message-ID: <20050729041031.GU16285@washoe.onerussian.com>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: 3BB6 E124 0643 A615 6F00  6854 8D11 4563 75C0 24C8
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running debian stable with 2.6.8 kernel but due to recent
failure of the SATA harddrive I've decided to upgrade to 2.6.11 + libata
patch (2.6.11-libata-dev1.patch.gz) and recent smartmontools

After everything worked out and I decided to rest in piece but I've
found that HDD LED light nomater what. It seems to turn off during BIOS
checks and then kicks in 1-2 secs after kernel starts booting. No
prominent harddrive activity noise can be heard but this drive is
quite silent so it is hard to say.

SATA drivers were compiled in the kernel to don't mess with initrd.

QUESTION: 

LED constantly ON - does it signal about a problem or may be just
that some status bit is hanging? Should I worry and try differen kernel
version?

YIKES: ran hddtemp /dev/sda and whole box hanged... SysRq keys - no
effect... heh heh... reboot -> nothing in logs

Detailed information on the system and drives (outputs of smartctl -a)
can be found

http://www.onerussian.com/Linux/bugs/ata/

Thank you in advance for ideas

P.S. was ata-dev patch incorporated in recent kernel versions so I could
use SMART with vanilla kernel?

-- 
Yaroslav Halchenko
  Graduate Student  CS Dept. UNM,  ABQ
        Linux User  175555
