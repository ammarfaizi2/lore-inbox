Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSF0KGl>; Thu, 27 Jun 2002 06:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSF0KGk>; Thu, 27 Jun 2002 06:06:40 -0400
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122]:15843 "EHLO
	pintail.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316774AbSF0KGj>; Thu, 27 Jun 2002 06:06:39 -0400
Message-ID: <3D1AE39A.9000200@mindspring.com>
Date: Thu, 27 Jun 2002 06:06:18 -0400
From: "John O'Donnell" <johnnyo@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /proc/cpuinfo incomplete for AMD 386DX 40?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC my address as I do not belong to the list.  TIA

I am just curious.

I have a file/web server that I updated with Slackware 8.1.  It runs
virtual web hosts, DynDNS, PPPoE, NFS, NAT and some other minor services.
This is an AMD 386 40Mhz with a 387 co-processor add-on and 32MB RAM.

It is functioning fine but I was poking around /proc/cpuinfo and it
says:

root@juanisan:/proc# cat cpuinfo
processor 
: 0
vendor_id 
: unknown
cpu family	: 3
model 
	: 0
model name	: 386
stepping 
: unknown
fdiv_bug 
: no
hlt_bug 
	: no
f00f_bug 
: no
coma_bug 
: no
fpu 
	: yes
fpu_exception 
: no
cpuid level	: -1
wp 
	: no
flags 
	:
bogomips 
: 5.17

Is there any harm in Linux not identifying stuff like the manufacturer.
I dont know if the i386 supports any extensions that would show up in
the flags field.  Think the bogomips is right?!?

Hey it runs GREAT and I love this old box I bought piece by piece when
it was new :-)  Like I said ... I was just curious.

I have not met a box Linux hasn't liked yet :-)
BTW it took half a day to compile 2.4.18 but It chugged away without a hitch!
Linux juanisan 2.4.18 #1 Wed Jun 12 19:29:12 EDT 2002 i386 unknown

TIA
Johnny O

-- 
=== Never ask a geek why, just nod your head and slowly back away.===
+==============================+====================================+
| John O'Donnell               |                                    |
|  (Sr. Systems Engineer,      | http://johnnyo.home.mindspring.com |
|  Net Admin, Webmaster, etc.) |   E-Mail: johnnyo@mindspring.com   |
+==============================+====================================+

