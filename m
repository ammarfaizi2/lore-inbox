Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267670AbTAHCIn>; Tue, 7 Jan 2003 21:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTAHCIn>; Tue, 7 Jan 2003 21:08:43 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:15912 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S267670AbTAHCIl>; Tue, 7 Jan 2003 21:08:41 -0500
Date: Wed, 8 Jan 2003 13:14:21 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org
Subject: DHCP-client-related options in Configure.help
Message-ID: <Pine.LNX.4.05.10301081312150.2087-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Separate patches to follow explicitly note that each of the two options
'Socket filtering' and 'Packet socket' are required for DHCP client.

Yep, I found out the hard way - build a kernel without these two and
DHCP client doesn't work at all.  Given the prevalance of DHCP, IMHO
it isn't reasonable to remain silent about DHCP's dependence on these
two options and counsel "if unsure, say N" (albeit in only one of the
above cases).

Patches for 2.2 and 2.4 will follow separately.  I'll also check 2.5.

Neale.

