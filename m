Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266206AbUGJKUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266206AbUGJKUM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 06:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUGJKUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 06:20:12 -0400
Received: from grobi.rob.uni-luebeck.de ([141.83.19.100]:25236 "EHLO
	grobi.rob.uni-luebeck.de") by vger.kernel.org with ESMTP
	id S266206AbUGJKUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 06:20:08 -0400
Subject: stock 2.6.7: modprobe ipmi_si hangs
From: Joerg Paysen <paysen@rob.uni-luebeck.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1089454814.2869.10.camel@ing>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jul 2004 12:20:15 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i have a intel serverboard SE7501WV2 wich supports ipmi 1.5.
i compiled ipmi_devintf, ipmi_msghandler and ipmi_si as kernel
modules. modprobing ipmi_msghandler and ipmi_devintf works fine and
dmesg shows:
 
ipmi message handler version v31
ipmi device interface version v31
IPMI System Interface driver version v31, KCS version v31, SMIC version
v31, BT
version v31
 
when i do a 'modprobe ipmi_si' modprobe does not return and ps ax
shows:
 
6380 ?        D      0:00 modprobe ipmi_si
 
and dmesg shows:
 
ipmi_si: Found SMBIOS-specified state machine at I/O address 0xca2
 
any help?
 
thanks all
joerg

