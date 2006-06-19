Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWFSXNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWFSXNm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 19:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWFSXNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 19:13:42 -0400
Received: from www.webhostingstar.com ([69.222.0.225]:16334 "HELO
	mail.webhostingstar.com") by vger.kernel.org with SMTP
	id S964977AbWFSXNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 19:13:41 -0400
Message-ID: <20060619180413.qlgd1oj9etmosckg@69.222.0.225>
Date: Mon, 19 Jun 2006 18:04:13 -0500
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Subject: kernel-x64-smp-multiprocessor-time util problem
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on dual core amd-athlon under 64bit-smp core

kernel compilation time:

time make -j 8
...
LD [M]  sound/usb/snd-usb-lib.ko
LD [M]  sound/usb/usx2y/snd-usb-usx2y.ko

real    18m0.948s
user    26m6.270s    ------bad
sys     4m22.256s    ------?bad
[xxx@localhost linux-2.6.17]$
--- real-clock time  is ~18 min -- user and system time doubled?

art@usfltd.com
