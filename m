Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbTGEWSr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 18:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbTGEWSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 18:18:47 -0400
Received: from [163.118.102.59] ([163.118.102.59]:24448 "EHLO
	mail.drunkencodepoets.com") by vger.kernel.org with ESMTP
	id S266519AbTGEWSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 18:18:46 -0400
Date: Sat, 5 Jul 2003 18:23:59 -0400
From: paterley <paterley@DrunkenCodePoets.com>
To: paterley <paterley@DrunkenCodePoets.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm2
Message-Id: <20030705182359.269b404d.paterley@DrunkenCodePoets.com>
In-Reply-To: <20030705175830.4ccfead8.paterley@DrunkenCodePoets.com>
References: <20030705132528.542ac65e.akpm@osdl.org>
	<20030705175830.4ccfead8.paterley@DrunkenCodePoets.com>
Organization: DrunkenCodePoets.com
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sat__5_Jul_2003_18:23:59_-0400_0823ceb0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Sat__5_Jul_2003_18:23:59_-0400_0823ceb0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

ok, I get 4 of a kernel oops during boot, but the kernel seems to stay happy.  I'm going to keep it going for fun to see if I can cause more oopses.  Attached is the first of the 4 oopses.

according to dmesg, immediately prior to the first oops, smbfs was unloaded due to unsafe usage.

Exact Error:
Module smbfs cannot be unloaded due to unsafe usage in include/linux/module.h:482

I'll be around for a few more hours if there is anything I can do to help answer questions.

Pat Erley 

--Multipart_Sat__5_Jul_2003_18:23:59_-0400_0823ceb0
Content-Type: application/octet-stream;
 name="debug.log"
Content-Disposition: attachment;
 filename="debug.log"
Content-Transfer-Encoding: base64

VW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IHZpcnR1
YWwgYWRkcmVzcyAwMDAwMDAwMAogcHJpbnRpbmcgZWlwOgowMDAwMDAwMAoqcGRlID0gMDAwMDAw
MDAKT29wczogMDAwMCBbIzFdClNNUCAKQ1BVOiAgICAwCkVJUDogICAgMDA2MDpbPDAwMDAwMDAw
Pl0gICAgTm90IHRhaW50ZWQgVkxJCkVGTEFHUzogMDAwMTAyODYKRUlQIGlzIGF0IDB4MAplYXg6
IGMwMzgwYzIwICAgZWJ4OiBmZmZmZmZmNCAgIGVjeDogY2YwN2QzYTAgICBlZHg6IGNjODQ3ZjY4
CmVzaTogY2YzYzI5NTAgICBlZGk6IGNmMDdkMmMwICAgZWJwOiBjYzg0N2YxOCAgIGVzcDogY2M4
NDdlZmMKZHM6IDAwN2IgICBlczogMDA3YiAgIHNzOiAwMDY4ClByb2Nlc3MgcmMgKHBpZDogMTE5
OCwgdGhyZWFkaW5mbz1jYzg0NjAwMCB0YXNrPWNmZDg2NmIwKQpTdGFjazogYzAxNjM3YWIgY2Yz
YzI5NTAgY2YwN2QyYzAgY2M4NDdmNjggY2YzYzI5YzAgY2YzYzI5NTAgY2M4NDdmNjggY2M4NDdm
NTAgCiAgICAgICBjMDE2M2ZmNyBjYzg0N2Y3MCBjZjA3ZDM4MCBjYzg0N2Y2OCBjYzg0N2Y0MCBj
Yzg0N2Y3MCAwMDAwMDAwMSBjZjA3ZDM4MCAKICAgICAgIDAwMDAwMDAyIGNmYTI4ZjAwIDAwMDA4
MjQxIDAwMDA4MjQxIGNmZDlhMDAwIGNjODQ3ZjljIGMwMTUzNzUxIGNmZDlhMDAwIApDYWxsIFRy
YWNlOgogWzxjMDE2MzdhYj5dIF9fbG9va3VwX2hhc2grMHg5Yi8weGQwCiBbPGMwMTYzZmY3Pl0g
b3Blbl9uYW1laSsweDJlNy8weDQyMAogWzxjMDE1Mzc1MT5dIGZpbHBfb3BlbisweDQxLzB4NzAK
IFs8YzAxNTNiZDM+XSBzeXNfb3BlbisweDUzLzB4OTAKIFs8YzAxMDk0NWY+XSBzeXNjYWxsX2Nh
bGwrMHg3LzB4YgoK

--Multipart_Sat__5_Jul_2003_18:23:59_-0400_0823ceb0--
