Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262109AbRETR3x>; Sun, 20 May 2001 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262111AbRETR3n>; Sun, 20 May 2001 13:29:43 -0400
Received: from [195.250.204.70] ([195.250.204.70]:25128 "EHLO raq.trendnet.si")
	by vger.kernel.org with ESMTP id <S262109AbRETR3h>;
	Sun, 20 May 2001 13:29:37 -0400
From: David Osojnik <dworf@siol.net>
Reply-To: dworf@siol.net
To: linux-kernel@vger.kernel.org
Subject: tcp_mem problem
Date: Sun, 20 May 2001 19:33:15 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01052019331500.00946@cool>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the system with problem is using kernel 2.4.2 on an P200 with 64mb ram. It 
has about 20 users that use the box... (ftp, telnet, lynx, bitchx,...).

the problem is when the parameter tcp_mem HIGH gets exeded after about a day 
of use! Then the box is going from the net and its not awailable. I tried to 
tune the system with adding more in proc tcp_mem but the problem is still 
there the box only lasts for bout 2h longer.

and i get this in messages

kernel: TCP: too many of orphaned sockets

It looks like my system is not droping closed sockets?

David
