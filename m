Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284361AbRLRR7L>; Tue, 18 Dec 2001 12:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284393AbRLRR7B>; Tue, 18 Dec 2001 12:59:01 -0500
Received: from w226.z065104013.sjc-ca.dsl.cnc.net ([65.104.13.226]:48370 "EHLO
	nile.platodesign.com") by vger.kernel.org with ESMTP
	id <S284386AbRLRR65>; Tue, 18 Dec 2001 12:58:57 -0500
From: "Wenyong Deng" <wydeng@platodesign.com>
To: <linux-kernel@vger.kernel.org>
Subject: How to use >3G memory per process
Date: Tue, 18 Dec 2001 09:48:44 -0800
Message-ID: <OHEPLPGMMIEGHANJIEBAIEPKCEAA.wydeng@platodesign.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I read about 3.5G-per_process (or 3.5G/0.5G user/kernel space) in this
mailing list, but I don't find the details of how to do it. I have installed
Redhat7.2 (kernel 2.4.10enterprise) on a dual CPU 4G memory PC. I wrote a
simple program to use malloc to allocate memory, and it can never exceeds
3G. libhoard didn't help either. My question is:

[1] What need to be done for the kernel to support 3.5G or more user address
space per process?

[2] What need to be done at compilation time? Any option for
compiler/linker?

Thanks,

--Wenyong

