Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265294AbUBCAzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUBCAzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:55:38 -0500
Received: from mbox2.netikka.net ([213.250.81.203]:16542 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S265294AbUBCAzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:55:35 -0500
Message-ID: <401EF49F.7000105@fi.homelinux.net>
Date: Tue, 03 Feb 2004 03:08:47 +0200
From: =?ISO-8859-1?Q?Ari_Mittil=E4?= <ari@fi.homelinux.net>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:1.6b) Gecko/20031222 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.2-rc1-ben1 problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I managed to get subjects kernel to compile and run here pretty much 
without problems except:
kernel loaded the
<clip>
Feb  2 22:38:15 603ev kernel: de2104x PCI Ethernet driver v0.6 (Sep 1, 
2003)
</clip>
driver.
Driver tried to get address and other info on dhcpcd but failed 
eventually and got info from cache.
This is what I got from lspci:
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 
03)
00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21041 
[Tulip Pass 3] (rev 21)
00:10.0 Class ff00: Apple Computer Inc. O'Hare I/O (rev 01)
00:11.0 VGA compatible controller: ATI Technologies Inc 264VT [Mach64 
VT] (rev 40)

Sys is pmac 4400/200 running debian unstable.

I hope this could at least give some pointers to the people doing the 
good work

For more info/questions, return is valid and I'm on freenode on 
#debian-ppc if needed
