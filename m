Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266553AbUGURix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266553AbUGURix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266558AbUGURiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:38:52 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:34021 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266553AbUGURis
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:38:48 -0400
Message-ID: <40FEAA3B.5010306@blue-labs.org>
Date: Wed, 21 Jul 2004 13:39:07 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040709
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2, usb HID is broken
Content-Type: multipart/mixed;
 boundary="------------070009040209060308090104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070009040209060308090104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

uhci_hcd 0000:00:10.0: host controller process error, something bad 
happened!
uhci_hcd 0000:00:10.0: host controller halted, very bad!
uhci_hcd 0000:00:10.0: host controller process error, something bad 
happened!
uhci_hcd 0000:00:10.0: host controller halted, very bad!
drivers/usb/input/hid-core.c: control queue full
drivers/usb/input/hid-core.c: control queue full
drivers/usb/input/hid-core.c: control queue full
drivers/usb/input/hid-core.c: control queue full
drivers/usb/input/hid-core.c: control queue full
drivers/usb/input/hid-core.c: control queue full

At this point the usb mouse is dead, there isn't any other dmesg 
information and the control queue full line repeats forever, apparently 
when packets from the mouse are received.



Linux Scott 2.6.8-rc2 #1 Tue Jul 20 23:02:45 EDT 2004 x86_64 5  GNU/Linux

Gnu C                  3.4.1
Gnu make               3.80
binutils               2.15.91.0.1
util-linux             2.12
mount                  2.12
module-init-tools      3.0
e2fsprogs              1.35
Linux C Library        2.3.4
Dynamic linker (ldd)   2.3.4
Procps                 3.2.2
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         nvidia ipt_REJECT iptable_filter iptable_mangle 
ipt_MASQUERADE iptable_nat ip_conntrack ip_tables


--------------070009040209060308090104
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------070009040209060308090104--
