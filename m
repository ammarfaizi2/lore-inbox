Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbTLKRW0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265169AbTLKRW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:22:26 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:54734 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S265154AbTLKRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:22:23 -0500
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups
	patch, no difference)
From: Disconnect <lkml@sigkill.net>
To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1071159379.1331.4.camel@slappy>
References: <1071159379.1331.4.camel@slappy>
Content-Type: text/plain
Message-Id: <1071163334.1324.15.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 12:22:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and the modules list:
Module                  Size  Used by    Tainted: P
i2c-dev                 4548   0 (unused)
i2c-core               13604   0 [i2c-dev]
ipt_mark                 472  18
ipt_state                568   0 (unused)
ipt_mac                  664   3
ip_nat_irc              2288   0 (unused)
ip_conntrack_irc        3120   1
ip_conntrack_ftp        4144   1 (autoclean)
ip_nat_ftp              3024   0 (unused)
iptable_filter          1772   1
iptable_mangle          2168   1
ipt_LOG                 3480   0 (unused)
ipt_TOS                 1016   0 (unused)
ipt_REJECT              3544   0 (unused)
ipt_MARK                 792   4
ipt_MASQUERADE          1592   8
ipt_REDIRECT             824   4
iptable_nat            17102   3 [ip_nat_irc ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT]
ip_conntrack           21892   4 [ipt_state ip_nat_irc ip_conntrack_irc ip_conntrack_ftp ip_nat_ftp ipt_MASQUERADE ipt_REDIRECT iptable_nat]
ip_tables              12544  14 [ipt_mark ipt_state ipt_mac iptable_filter iptable_mangle ipt_LOG ipt_TOS ipt_REJECT ipt_MARK ipt_MASQUERADE ipt_REDIRECT iptable_nat]
soundcore               4036   0 (autoclean)
sd_mod                 11084   0 (autoclean) (unused)
sg                     28540   0 (autoclean) (unused)
sr_mod                 15640   0 (autoclean) (unused)
scsi_mod               89056   3 (autoclean) [sd_mod sg sr_mod]
ide-cd                 32096   0 (autoclean)
cdrom                  28320   0 (autoclean) [sr_mod ide-cd]
nvnet                  26400   1
mousedev                4276   0 (unused)
hid                    21572   0 (unused)
usbmouse                2264   0 (unused)
ehci-hcd               17868   0 (unused)
ipv6                  182548  -1
tulip                  40960   1
crc32                   2880   0 [tulip]
keybdev                 2084   0 (unused)
usbkbd                  3640   0 (unused)
input                   3488   0 [mousedev hid usbmouse keybdev usbkbd]
usb-ohci               19656   0 (unused)
usbcore                65100   1 [hid usbmouse ehci-hcd usbkbd usb-ohci]

-- 
Disconnect <lkml@sigkill.net>

