Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbWCULVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbWCULVe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 06:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbWCULVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 06:21:34 -0500
Received: from web38002.mail.mud.yahoo.com ([209.191.124.113]:63872 "HELO
	web38002.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030294AbWCULVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 06:21:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RGKtass1D7nu06FDIHtkT+ezT3c3MYRxcBQVo1UEfYo5TvkauLBCpZWnTw4U4uXRXSGWtPSEuSEF4x6hjRjm5vEiJTrJG0stMsiSXdaSCnKdVlSrKO/4tKpnQod7eaSNl8unC22Yexjrnnba4s65PSrp7ifiDZ3mcILC3A3GuPw=  ;
Message-ID: <20060321112132.36531.qmail@web38002.mail.mud.yahoo.com>
Date: Tue, 21 Mar 2006 03:21:32 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: Makefile problem
To: kernel newbies <kernelnewbies@nl.linux.org>
Cc: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I have some Makefile questions
1)Why a kernel module in 2.6 kernel cannot be compiled
with single gcc command? Why it requires Makefile in
current directory so that i can use Makefile?

2) why following command used to compile 2.4 kernel
module fails on 2.6 kernel
gcc  -D__KERNEL__ -DMODULE -DLINUX -O2 -Wall
-Wstrict-prototypes -I/lib/modules/`uname
-r`/build/include -c -o example.ko example.c

3) Is that because of gcc cannot create .ko file??
then what header changes occurred from .o to .ko
module implementaion?

Thanks & Regards,
cranium



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
