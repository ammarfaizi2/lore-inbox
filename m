Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMKXt>; Mon, 13 Nov 2000 05:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129050AbQKMKXk>; Mon, 13 Nov 2000 05:23:40 -0500
Received: from relay03.valueweb.net ([216.219.253.237]:60169 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id <S129040AbQKMKXb>; Mon, 13 Nov 2000 05:23:31 -0500
Message-ID: <3A0FC230.BF7E537B@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Mac-buttons emulation broken in 2.4.0-test10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2000 05:23:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The mac_hid_mouse_emulate_buttons() in drivers/macintosh/mac_hid.c
which takes care of emulating multiple buttons on a mac doesn't
seem to be used anywhere. In fact, by doing a "grep -r mac_hid... *"
in the kernel's base directory yields only one result and it's
the one in mac_hid.c. Shouldn't this be called upon from the
keyboard and mouse handlers?

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
