Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSLBIxx>; Mon, 2 Dec 2002 03:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261663AbSLBIxx>; Mon, 2 Dec 2002 03:53:53 -0500
Received: from f130.law3.hotmail.com ([209.185.241.130]:45061 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S261305AbSLBIxw>;
	Mon, 2 Dec 2002 03:53:52 -0500
X-Originating-IP: [192.115.130.1]
From: "Nadav Rotem" <nadav256@hotmail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 02 Dec 2002 01:01:15 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1306u7WP0YpGmx3qmM0001808b@hotmail.com>
X-OriginalArrivalTime: 02 Dec 2002 09:01:15.0914 (UTC) FILETIME=[5EEDF6A0:01C299E1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to whom it may concern,

I am having some problems with recent kernels. The SIS DRI module since 
2.4.18 through 2.4.20 will not compile ^H ^H ^H Link properly. The Error I 
get is undefined reference to sis_free() and sis_malloc(). I believe it has 
to do with the dependencies or make file linking with a missing .o file.

The problem occures whenever I try to compile the module into the kernel ( 
[*] sis ).
when I try to compile it as a module it fails when I go through "make 
modules_install" with the same error.

The problem is in the Xfree 4.1 DRI driver (I didnt try Xfree 4.0 DRI 
driver). The regular kernel X sis driver works just fine just with no DRI 
support.

I am running Redhat 7.3 - 2.4.18 &&  2.4.20.
I believe it is not a local problem since I "make clean" or "make mrproper" 
and I had no problems with compiling older kernels. It also happens on new 
downloaded kernels. A friend also told me that he had some problems with the 
Sis module when compiling the frame buffer. I am not sure if it is related 
but he said that it does produce similar errors. (debian-current)


Thanks,
Nadav




_________________________________________________________________
Add photos to your e-mail with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

