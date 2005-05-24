Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVEXN4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVEXN4n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVEXN4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 09:56:43 -0400
Received: from tag.witbe.net ([81.88.96.48]:28590 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S261310AbVEXN4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 09:56:37 -0400
Message-Id: <200505241356.j4ODuaR07145@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <linux-kernel@vger.kernel.org>
Cc: <rol@witbe.net>
Subject: Linux and Initrd used to access disk : how does it work ?
Date: Tue, 24 May 2005 15:56:36 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
thread-index: AcVgaGZ1KR8BfKlSSjKvjJW1ScbrTQ==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've been fighting for a few days with binary modules from some manufacturer
for hardware support of disk controler, and I'm at a point where I need
some more understanding.

1 - My machine contains an Adaptec SATA Raid based on Marvel 88SX60xx
    so I need to used the aar81xxx binary module,

2 - This module is presented as required to access the disk (when 
    installing a RH kernel, it says that no disk is present unless the
    module is loaded),

3 - When booting the kernel from disk after installation, the module is 
    loaded so the machine can access the disk...

... BUT ... how can the machine /
 - boot the kernel,
 - access the initrd image and uncompress it,
 - read the binary module inside and load it
BEFORE loading the module itself, if it is mandatory to access the disk.

And if it is not, then how can I do the installation ?

I suspect this should be fairly trivial, but I've been thinking about
for long, and it looks like chicken and egg to me...

Any help ?

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's 
too young to have logged on yet. Here's what I worry about. I worry that 
10 or 15 years from now, she will come to me and say 'Daddy, where were 
you when they took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
 

