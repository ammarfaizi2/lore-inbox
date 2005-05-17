Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVEQHBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVEQHBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEQHBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:01:49 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:43873 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S261252AbVEQHBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:01:43 -0400
X-ME-UUID: 20050517070142159.26EFA1C000CA@mwinf1107.wanadoo.fr
Message-ID: <428996D5.9090309@wanadoo.fr>
Date: Tue, 17 May 2005 09:01:41 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Unable to handle kernel NULL pointer dereference at virtual address
 00000009
Content-Type: multipart/mixed;
 boundary="------------000203030206060004020809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000203030206060004020809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have a lot of trouble on machines with USB disk.
Some time process which access to this disk are blocked and shutdown command don't stop the system (unable to remove usb-uhci module).

I'm using 2.4.26 kernel

Do you need more information ?

To solve my problem, is it possible to take usb module from 2.4.30 ?

Thanks,

 Yves

<6>usb.c: USB disconnect on device 00:07.3-0 address 1
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000009
<4> printing eip:
<4>d0d04bf2
<1>*pde = 00000000
<4>Oops: 0000
<4>CPU:    0
<4>EIP:    0010:[<d0d04bf2>]    Not tainted
<4>EFLAGS: 00010246
<4>eax: ceb9da00   ebx: 00000001   ecx: fffffffd   edx: d0d08bec
<4>esi: 00000000   edi: c84200fb   ebp: 00000000   esp: cd4e5ef8
<4>ds: 0018   es: 0018   ss: 0018
<4>Process maitre (pid: 686, stackpage=cd4e5000)
<4>Stack: 00000000 ce5fd200 c8421f00 00000000 00000000 d0d04e5c 00000000 c84200d4 
<4>       c8421f00 ceb9da00 00000001 c8421f00 c8420071 c8420000 ce5fd200 d0d04fa9 
<4>       c8420071 c8421f00 ce5fd200 ce72d144 000000dd cdf8c370 d0d09d80 00000000 
<4>Call Trace:    [<d0d04e5c>] [<d0d04fa9>] [<d0d09d80>] [<d0d051a6>] [<c0131c16>]
<4>  [<c0108843>]
<4>
<4>Code: 3b 73 08 7d 23 3b 7c 24 20 77 94 56 53 8b 54 24 28 52 57 8b 
<4> <4>usb-uhci.c: interrupt, status 20, frame# 0
<6>usb.c: USB bus 2 deregistered


--------------000203030206060004020809
Content-Type: text/x-vcard; charset=utf-8;
 name="crespin.quartz.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="crespin.quartz.vcf"

begin:vcard
fn:Yves Crespin
n:Crespin;Yves
org:Quartz
adr:Les Ardillais;;104, Impasse Moissan;CROLLES;;38920;France
email;internet:Crespin.Quartz@Wanadoo.fr
tel;work:04.76.92.21.91
tel;cell:06.86.42.86.81
x-mozilla-html:FALSE
url:http://crespin.quartz.free.fr/
version:2.1
end:vcard


--------------000203030206060004020809--

