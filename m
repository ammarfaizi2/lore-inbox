Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTFDAPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTFDAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:15:22 -0400
Received: from dan.arc.nasa.gov ([143.232.69.77]:9345 "EHLO rudi.arc.nasa.gov")
	by vger.kernel.org with ESMTP id S262000AbTFDAPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:15:20 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dan Christian <Daniel.A.Christian@NASA.gov>
Reply-To: Daniel.A.Christian@NASA.gov
Organization: NASA Ames Research Center
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc7 SMP module unresolved symbols
Date: Tue, 3 Jun 2003 17:28:41 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306031728.41982.Daniel.A.Christian@NASA.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can build a 2.4.21-rc7 Athlon single processor kernel and modules 
without problem.

When I enable SMP, most (but not all) modules have unresolved symbols.  
This is basic stuff like prink and kmalloc.  I've tried both with and 
without symbol versioning.

The build line was:
make clean && make dep && make bzImage && make modules && make 
modules_install

I'm building on RedHat 7.3.
#rpm -q gcc binutils modutils
gcc-2.96-113
binutils-2.11.93.0.2-11
modutils-2.4.18-3.7x

I'm not on the list.  Please CC me.

-Dan
