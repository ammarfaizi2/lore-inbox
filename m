Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261527AbTA1WKc>; Tue, 28 Jan 2003 17:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261530AbTA1WKb>; Tue, 28 Jan 2003 17:10:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:4842 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261527AbTA1WKa>;
	Tue, 28 Jan 2003 17:10:30 -0500
Date: Tue, 28 Jan 2003 14:40:20 -0600
From: latten@austin.ibm.com
Message-Id: <200301282040.h0SKeKO30480@faith.austin.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: SIGHUP on tty while logging in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am using a serial port (ttyS0) for my console and 
whenever I "cu" into the port and get a login prompt, I sometimes get 
a SIGHUP right after entering the user name, thus resulting 
in my being disconnected before I get a chance to complete login. 
It is random. Sometimes login proceeds with no problem and 
sometimes I get the SIGHUP during login. 
This happens even when I do not configure
my kernel to use my serial port as a console and I just
cu into the port and login. 

Has anyone else experienced this? One of my machines
is linux-2.5.58 and the other is 2.5.59. It happens on both.

My tty settings look ok and it is not my getty applications. I tried 
agetty and mgetty and I got the same results. I am wondering if it is
the driver... 

Thanks,
Joy
