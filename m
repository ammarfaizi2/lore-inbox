Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932537AbWCXS11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWCXS11 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWCXS11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:27:27 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:759 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932537AbWCXS10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:27:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=l4KCg6LwkZS7PBz+PFfpfGZwnJ7SeWOOlxRFIAv5xsca45RRlptSeJVcqH9dM02dD2tEfwNG5YHEufMGEsDaNrJH7rfMtHT+4J48WHPzwfGYo/9dRMC7Y7xaXt8OB8QPsbWPESVY4sRCl/GWIKSZWyDML7Ffk5bJ2RJedg2RZg4=
Message-ID: <4424476C.5080103@gmail.com>
Date: Fri, 24 Mar 2006 14:24:28 -0500
From: Segin <segin2005@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051202)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux booting problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having a problem booting *any* modern version of Linux on y Compaq 
Presario CDS 520. It keeps having a kernel panic after trying to read a 
compressed ramdisk (for floppy-based boots, which is all I can try, the 
system was made before el-torito became standard).
All kernel panics produce similar output, the most recent from 2.0.31 is:
divide error: 0000
CPU:    0
EIP:    0010:[<0017f803>]
EFLAGS: 00000246
eax: 00000035   ebx: 00000010   ecx: 00000008   edx: 00000e52
... and some other stuff, the system's APM went active and it locked up, 
but it also did say "panic: tried to kill init!".

I have tried many kernel version from 2.0.0 up to the latest release. 
All of them exibit the same behaviour and divine error. The system has 
no FPU, and 'no387' is used as a kernel option. All custom kernels have 
math emulation ENABLED.

As a side note, Linux 0.99.15 boots just fine using loadlin.
