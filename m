Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFFVZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTFFVZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:25:54 -0400
Received: from s1.uscreditbank.com ([192.41.74.10]:33031 "EHLO
	s1.uscreditbank.com") by vger.kernel.org with ESMTP id S262288AbTFFVZt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:25:49 -0400
Date: Fri, 6 Jun 2003 15:39:39 -0600
From: jmerkey@s1.uscreditbank.com
To: linux-kernel@vger.kernel.org
Cc: jmerkey@utah-nac.org
Subject: 2.4.20 Modprobe setting of eth0,eth1 does not seem to work
Message-ID: <20030606153939.A20699@s1.uscreditbank.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



In 2.4.20 if I attempt to use the Intel multiport e1000 drivers with 
modules.conf trying to hard set the eth0,eth1, etc. assignments modprobe does
not appear to be assigning the adapter aliases correctly.  I am assuming
this may be due to an interface issue between the Keyboard and monitor. :-)

Modules.conf file attached.  Anyone got any ideas here?

Jeff



--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="modules.conf"

alias parport_lowlevel parport_pc
alias usb-controller usb-uhci
alias eth0 e1000
alias eth1 e1000
alias eth2 e1000
alias eth3 e1000
alias eth4 e1000
alias eth5 e1000
alias eth6 e1000
alias eth7 e1000
alias eth8 e1000
alias eth9 e1000
options eth0 -o e1000-0 io=0x4000 irq=96
options eth1 -o e1000-1 io=0x4040 irq=97
options eth2 -o e1000-2 io=0x3000 
options eth3 -o e1000-3 io=0x3040
options eth4 -o e1000-4 io=0x3080
options eth5 -o e1000-5 io=0x30c0
options eth6 -o e1000-6 io=0x4080
options eth7 -o e1000-7 io=0x40c0
options eth8 -o e1000-8 io=0x5000
options eth9 -o e1000-9 io=0x5040

--pf9I7BMVVzbSWLtt--
