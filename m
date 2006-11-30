Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967736AbWK3Amt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967736AbWK3Amt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967738AbWK3Amt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:42:49 -0500
Received: from web26101.mail.ukl.yahoo.com ([217.12.10.225]:1199 "HELO
	web26101.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S967736AbWK3Ams (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:42:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.es;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=GXuO8X7G/cCsC6Wcl7qyUyuaF++Zj6w7FViDROaPPZujHg017gcdQWWt/6QHuTXeIJ17+SfUpvU0D13vjBkXeXhSfoHBZML55RbHiyAKfFe2bbYr++4Zn7+l+UW9/cOJBDuy7UVRTAQ5QopYRzz60gNozqHhhkEnPK4ZIco0PEc=;
X-YMail-OSG: K4kFhO0VM1kowZlA58wRMtBkpdr4tuqr0oQtOhH1NVCZAfV0GDbHLTVnASgFeZalyaLlxOfKgYXJsiSic1quMSE8JARaO0B4ympRFs9IRswNi9ERHNGFYj1sH7i5jijk.LGiBIGv0gsfsX391t5492GkihzmBIjSz8bJ1ImRe_69weuByrXrUq9kWA--
Date: Thu, 30 Nov 2006 01:42:47 +0100 (CET)
From: =?iso-8859-1?q?Ariel=20Ch=FFffffe1vez=20Lorenzo?= 
	<achavezlo@yahoo.es>
Subject: hrtimer.h
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <248625.39629.qm@web26101.mail.ukl.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since the kernel 2.6.18 has incorporated the high
resolution timer itself, I'm trying to test it, but on
my GNU/Debian I can't figure out how to include
hrtimer.h, that is on /usr/src/linux/include/, the
headers.

I use the following command to try to compile it.

gcc -D__KERNEL__ -I /usr/src/linux/include ex.c


ex.c is just the inclusion of hrtimer.h

#include <linux/hrtimer.h>
int main()
{
 return 0;
}


and I get this:



In file included from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/asm/thread_info.h:16,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/thread_info.h:21,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/preempt.h:9,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/spinlock.h:49,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/seqlock.h:29,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/time.h:7,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/ktime.h:24,
                 from
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/linux/hrtimer.h:19,
                 from ex.c:1:
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/asm/processor.h:80:
error: ‘CONFIG_X86_L1_CACHE_SHIFT’ undeclared here
(not in a function)
/usr/src/linux-headers-2.6.18sbr-24-11-06/include/asm/processor.h:80:
error: requested alignment is not a constant


I will appreciate any hint.
Thanks in advance..

Ariel



		
______________________________________________ 
LLama Gratis a cualquier PC del Mundo. 
Llamadas a fijos y móviles desde 1 céntimo por minuto. 
http://es.voice.yahoo.com
