Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbTC3C1n>; Sat, 29 Mar 2003 21:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263502AbTC3C1n>; Sat, 29 Mar 2003 21:27:43 -0500
Received: from pcow057o.blueyonder.co.uk ([195.188.53.94]:35592 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S263501AbTC3C1f>;
	Sat, 29 Mar 2003 21:27:35 -0500
Subject: [Fwd: 2.5 module-init-tools/mk_initrd problems]
From: Sid Boyce <sboyce@blueyonder.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-w3Vu9I+tSTPE+dNh9acP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Mar 2003 02:38:53 +0000
Message-Id: <1048991933.850.75.camel@barrabas>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-w3Vu9I+tSTPE+dNh9acP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Regards
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

--=-w3Vu9I+tSTPE+dNh9acP
Content-Disposition: inline
Content-Description: Forwarded message - 2.5 module-init-tools/mk_initrd
	problems
Content-Type: message/rfc822

Subject: 2.5 module-init-tools/mk_initrd problems
From: Sid Boyce <sboyce@blueyonder.co.uk>
To: linux_kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Mar 2003 20:46:19 +0000
Message-Id: <1048970779.847.70.camel@barrabas>
Mime-Version: 1.0

	On both SuSE 8.1 and Mandrake 9.1rc2, I can't get mk_initrd to find
modules.
	I've installed module-init-tools 0.9.10 (SuSE 8.1) and 0.9.9 (Mandrake
9.1rc2), mkinitrd 3.4.32 (SuSE 8.1) and 3.1.6 (Mandrake). "depmod -ae
2.5.66-ac1" finds no problems. 
"mkinitrd --preload reiserfs --preload aic7xxx /boot/initrd-2.5.66-ac1
2.5.66-ac1" returns message on both systems e.g "no module reiserfs
found for kernel 2.5.66-ac1".
 strace says it's at least trying to look in the right top directory ...
stat64("/lib/modules/2.5.66-ac1", {st_mode=S_IFDIR|0755, st_size=288,
...}) = 0
	I can't see why it's not searching further down to where the module is.
Regards
Sid.
-- 
Sid Boyce ... hamradio G3VBV ... Cessna/Warrior Pilot
Linux only shop

--=-w3Vu9I+tSTPE+dNh9acP--

