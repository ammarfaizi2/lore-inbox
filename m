Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbTGEUTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 16:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbTGEUTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 16:19:37 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:39396 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S266481AbTGEUT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 16:19:29 -0400
From: imunity@softhome.net
To: linux-kernel@vger.kernel.org
Subject: Kernel Compiling using =?iso-8859-1?Q?=22make=20rpm=22?= question PLEASE!!
Date: Sat, 05 Jul 2003 14:33:59 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [12.249.189.237]
Message-ID: <courier.3F073637.000070EE@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I would not be asking this question but I have to say someone maybe even 
myself will have to make a DOC on this cause there are none!!!! 

The convention method for configuring, compiling and installing a kernel I 
am very clear on but why cannot find any documents on how to compile it 
using "make rpm" or recompile or "rpmbuild -bb" 

I have searched the bookstores, www.redhat.com, www.tldp, most newgroups and 
almost every single search result from www.google.com/linux. 


Conventional Method: 

tar -zxvf kernel.xx  or rpm -ivh kernel-source.i386.rpm
ln -s kernel.xx linux
make clean
make mrproper
make menuconfig
make dep
make clean
make bzImage
make modules
make modules_install
make install
mkinitrd 

 

RPM METHOD: 

tar -zxvf kernel.xx  or rpm -ivh kernel-source.i386.rpm
ln -s kernel.xx linux  # I think this step may be need if you have a rpm 
kernel source!! 

make clean
make mrproper
make menuconfig
make rpm
rpm -ivh /usr/src/redhat/RPMS/i386/kernel-xx.i386.rpm
mkinitrd 

 


Just currious as to why I cannot find something as simple as that for "make 
rpm" 


Still trying to figure out how to use "rpmbuild -bb" 

