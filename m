Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbTJDUL7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262759AbTJDUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 16:11:59 -0400
Received: from mx2.magma.ca ([206.191.0.250]:11485 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S262755AbTJDUL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 16:11:58 -0400
Date: Sat, 4 Oct 2003 16:11:56 -0400 (EDT)
Message-Id: <200310042011.h94KBunf016726@webmail2.magma.ca>
To: linux-kernel@vger.kernel.org
From: "Javier Govea" <jgovea@magma.ca>
Subject: INTERFACE ADDRESSES
X-Account: jgovea
X-Sender-IP: 209.217.122.119
X-INFO: Folder - 0, Message - 0, MimeBody - 0
Mime-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to get the ip addresses of every interface in my host, is there any function within
the kernel that already does this??? I know there is a function, called ip_dev_find(u32
addr) in fib_frontend.c, where I can pass the ip address of an intefarce and it will
return me a net_device*. I want a function that does exactely the opposite. Is there such
a function in the kernel?? if so, can somebody point me to file??? 

If there is no such a function, then I can write it myself, but I need some help for that.
I don't know where the ip addresses of the interfaces are stored, is there something like
a linked list or table where each node or entry has a device and its ip address??? where
can i look for the ip addresses? and the devices???

Thanx in advance to all...
Xavier

