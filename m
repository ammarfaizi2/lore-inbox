Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbVJDSzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbVJDSzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbVJDSzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 14:55:22 -0400
Received: from web35905.mail.mud.yahoo.com ([66.163.179.189]:58806 "HELO
	web35905.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964914AbVJDSzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 14:55:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=R7+P7P4mqmKWBlAnMf0c86emee+S6mTu3ST9n0bmid1gVqafD+EshWJd8on3J2AZBJ3e7MRRZT2T1/TNe95wFN1B74r96XBZGcI3qC1BnaSrdKdRSG+FTCHbQE0bEMl7RhnmoGEB2poc8YRGiuBaThU06r/hQ3zZqtLrBuIG/00=  ;
Message-ID: <20051004185520.9489.qmail@web35905.mail.mud.yahoo.com>
Date: Tue, 4 Oct 2005 11:55:20 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: error during compiling the kernel 2.6.10 on FC3 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi ,
    I am compiling kernel 2.6.10 on FC3 as usual 
using following steps  

1) make Menuconfig
2) make bzImage
3) make modules
           These 3 steps work properly.
4) make modules_install

        But in 4 th step i got error after some moules

are installed

Error Message  is like this
if [ -r System.map ]; then /sbin/depmod -ae -F
System.map  2.6.10; fi /bin/sh: line 1: 11366
Terminated              /sbin/depmod -ae -F System.map
2.6.10
make: *** [_modinst_post] Error 143

Due to this error initrd is not made in step 
5) make install

     I also want to know what  Error 143 indicates.

What should i do. How to overcome this error

              Thanks in advance 


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
