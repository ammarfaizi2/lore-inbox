Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUBXN7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUBXN7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:59:23 -0500
Received: from mail.artsci.net ([64.29.142.100]:46601 "EHLO jadsystems.com")
	by vger.kernel.org with ESMTP id S262151AbUBXN7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:59:22 -0500
Date: Tue, 24 Feb 2004 05:58:10 -0800
Message-Id: <200402240558.AA3585540272@jadsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jim Deas" <jdeas0648@jadsystems.com>
Reply-To: <jdeas0648@jadsystems.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: <IMail v6.05>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can someone point me in the right direction. 
I am getting a oops on a driver I am porting from 2.4 to 2.6.2 kernel. 
I have expanded the file_operations structures and have a driver that loads and inits the hardware but when I call the open function I get an oops. The best I can track it is 

EIP 0060:[c0188954] 
chrdev_open +0x104 

What is the best debug tool to put this oops information in clear sight? It appears to never get to my modules open routine so I am at a debugging crossroad. What is the option on a kernel compile to get the compile listing so I can see what is at 0x104 in this block of code?


