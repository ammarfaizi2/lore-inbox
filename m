Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTDHQjO (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbTDHQjO (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:39:14 -0400
Received: from tomts25-srv.bellnexxia.net ([209.226.175.188]:19121 "EHLO
	tomts25-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261521AbTDHQjK (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:39:10 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm1
Date: Tue, 8 Apr 2003 12:50:55 -0400
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030408042239.053e1d23.akpm@digeo.com> <200304080917.15648.tomlins@cam.org> <20030408091048.002a2e08.akpm@digeo.com>
In-Reply-To: <20030408091048.002a2e08.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304081250.55925.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On April 8, 2003 12:10 pm, Andrew Morton wrote:
> Does the below patch help?

Yes.  With it 67-mm1 boots.  I do find the following in dmesg though: 

CPU: AMD-K6(tm) 3D+ Processor stepping 01
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Initializing RT netlink socket
mtrr: v2.0 (20020519)
pty: 256 Unix98 ptys configured
Bad boy: i8042 (at 0xc0320738) called us without a dev_id!
Bad boy: i8042 (at 0xc0320852) called us without a dev_id!
Bad boy: i8042 (at 0xc020a9e8) called us without a dev_id!
serio: i8042 AUX port at 0x60,0x64 irq 12
Bad boy: i8042 (at 0xc020a9e8) called us without a dev_id!
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
PCI: PCI BIOS revision 2.10 entry at 0xfb520, last bus=1
PCI: Using configuration type 1
BIO: pool of 256 setup, 14Kb (56 bytes/bio)

Box seems to work fine.  There is nothing plugged onto AUX
as my mouse is USB.  The keyboard is plugged into the other
PS2 port...

Ed

