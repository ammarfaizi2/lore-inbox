Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUESB2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUESB2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 21:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbUESB2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 21:28:47 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:28619 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S263772AbUESB2n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 21:28:43 -0400
Message-ID: <40AAB845.9090505@blue-labs.org>
Date: Tue, 18 May 2004 21:28:37 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [OOPS] null ptr dereference, 2.6.6, ov511 usb webcam
Content-Type: multipart/mixed;
 boundary="------------020604010007070009050306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020604010007070009050306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

drivers/usb/media/ov511.c: USB OV511 video device found
drivers/usb/media/ov511.c: model: AverMedia InterCam Elite
drivers/usb/media/ov511.c: Sensor is an OV7610
drivers/usb/media/ov511.c: Device at usb-0000:00:07.2-2.3 registered to 
minor 0
Unable to handle kernel NULL pointer dereference at virtual address 00000095
 printing eip:
c0390179
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
CPU:    0
EIP:    0060:[<c0390179>]    Not tainted
EFLAGS: 00010282   (2.6.6)
EIP is at ov51x_v4l1_ioctl+0x29/0x90
eax: dbc0d494   ebx: 00000095   ecx: 00000095   edx: d617bf00
esi: 00000001   edi: d617bf00   ebp: dbb71bc0   esp: daccdf80
ds: 007b   es: 007b   ss: 0068
Process camsource (pid: 8158, threadinfo=daccd000 task=d625d1b0)
Stack: 080630b0 08063068 80887614 80887614 c0632d00 d617bf00 ffffffe7 
c015e4a9
       0806319c dbb71bc0 00000000 3b7e2d4c 00000007 08063138 0806319c 
daccd000
       c0103e89 00000007 80887614 0806319c 08063138 0806319c 40b2fa48 
00000036
Call Trace:
 [<c015e4a9>] sys_ioctl+0xe9/0x240
 [<c0103e89>] sysenter_past_esp+0x52/0x71

Code: ff 8e 94 00 00 00 0f 88 cb 25 00 00 31 c0 85 c0 ba fc ff ff


--------------020604010007070009050306
Content-Type: text/x-vcard; charset=utf8;
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


--------------020604010007070009050306--
