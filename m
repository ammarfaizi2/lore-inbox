Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUDSEsM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262936AbUDSEsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 00:48:12 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:37373 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S262238AbUDSEsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 00:48:09 -0400
Message-ID: <40835B84.1090202@inostor.com>
Date: Sun, 18 Apr 2004 21:54:28 -0700
From: Shesha Sreenivasamurthy <shesha@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: lvcreate -- ERROR "Cannot allocate memory" creating VGDA
References: <20040414142410.17997.qmail@web20729.mail.yahoo.com>
In-Reply-To: <20040414142410.17997.qmail@web20729.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I am trying the following "lvcreate" command and  I am hit an error. I 
googled for this error, and I can see it being listed in lotz of places, 
but without any solution or workaround.

Configuration:
----------------------
    RH-Linux 2.4.26
    1GB memory.

But the same command works fine, if I have only 512 MB RAM. Any help is 
highly appreciated.

Thanks
Shesha

---------------
[root@mc26300a root]# lvcreate -s -l 4306 -n stest /dev/VG_H41/LV_H41
lvcreate -- WARNING: the snapshot will be automatically disabled once it 
gets full
lvcreate -- INFO: using default snapshot chunk size of 64 KB for 
"/dev/VG_H41/ste1"
lvcreate -- ERROR "Cannot allocate memory" creating VGDA for 
"/dev/VG_H41/ste1" in kernel
----------------


