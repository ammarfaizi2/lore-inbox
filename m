Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTDZCEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 22:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbTDZCEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 22:04:01 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:3279 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264590AbTDZCD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 22:03:58 -0400
Date: Fri, 25 Apr 2003 22:14:12 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Coding regulations
To: linux-kernel@vger.kernel.org
Message-id: <200304252214120970.019AF211@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah just a quick question.  Not that I am actually able to code kernel
level drivers (I wish), but when I do code that would be part of one, I would
prefer not to make it a hassle for others to impliment.

To the point, I tend to do C++ classes, then make a C interface.  Makes
it easier for me to program.  Now, you may not want to mess with the C++
and convert it over, plus you may not want C++ code in the kernel.  I am
about to start on the compression code for the fast algorithm that may be
used for kernel swap compression and compressed swap-on-ram, assuming
these swap modules are implimented.  I don't want to cause any... oddities.

The C interfaces are just C functions that take a numerical handle which
identifies a class in a self-sorting linked list, as well as all the other data that
goes to each member function of the classes.  I can still do it in C alone but
it's a little more work.  Just don't wanna mess anyone/anything up.

--Bluefox Icy

