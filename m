Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbQLVPeu>; Fri, 22 Dec 2000 10:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131991AbQLVPek>; Fri, 22 Dec 2000 10:34:40 -0500
Received: from p3EE3CA44.dip.t-dialin.net ([62.227.202.68]:3076 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131478AbQLVPe2> convert rfc822-to-8bit; Fri, 22 Dec 2000 10:34:28 -0500
Date: Fri, 22 Dec 2000 15:47:57 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "Theodore Ts'o" <tytso@valinux.com>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
Subject: FAIL: 2.2.18 + AA-VM-global-7 + serial 5.05
Message-ID: <20001222154757.A1167@emma1.emma.line.org>
Mail-Followup-To: Theodore Ts'o <tytso@valinux.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrea Arcangeli <andrea@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a vanilla 2.2.18 that I patch Andrea Arcangeli's VM-global-7
patch (for 2.2.18pre25) on top, as well as I²C 2.5.4, the current
--12-09 IDE.2.2.18 patch and ReiserFS 3.5.28. So far, so good. If I now
patch serial 5.05 on top of that, the kernel itself detects devices, but
does nothing if it's to boot /sbin/init. ctrl-alt-del and Magic SysRq
are both functional and can reboot the machine.

Taking out either the VM-global-7 patch or the serial 5.05 update fixes
this.

I suspect that these patches are mutually incompatible.

Could somebody please have a look at this? I will test or provide more
information as requested.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
