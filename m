Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271654AbRHUN05>; Tue, 21 Aug 2001 09:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271657AbRHUN0r>; Tue, 21 Aug 2001 09:26:47 -0400
Received: from [195.66.192.167] ([195.66.192.167]:60679 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271654AbRHUN0j>; Tue, 21 Aug 2001 09:26:39 -0400
Date: Tue, 21 Aug 2001 16:27:19 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <11128833219.20010821162719@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
CC: Keith Owens <kaos@ocs.com.au>
Subject: Re[2]: depmod -a: unresolved symbols
In-Reply-To: <29026.998368838@kao2.melbourne.sgi.com>
In-Reply-To: <29026.998368838@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Keith,

Tuesday, August 21, 2001, 7:40:38 AM, you wrote:
KO> On Mon, 20 Aug 2001 17:35:57 +0300,
KO> VDA <VDA@port.imtp.ilyichevsk.odessa.ua> wrote:
>>In kernel sources I see:
>>nfsd_linkage defined and EXPORT_SYMBOLed in fs/filesystems.c
>>(linked in vmlinux and bzimage, I see it in System.map),
>>referenced from fs/nfsd/nfsctl.c (later linked into nfsd.o)
>>So, why modprobe can't see it?
>>
>>kernel: 2.4.5
>>I did
>>make dep && \
>>make clean && \
>>make bzImage && \
>>make modules && \
>>make modules_install

KO> http://www.tux.org/lkml/#s8-8

Well... now it seems to work for me. Thanks for your help.
Rather annoying to know that kernel build system is itself buggy...
-- 
Best regards,
VDA                            mailto:VDA@port.imtp.ilyichevsk.odessa.ua


