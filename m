Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261943AbREQWyQ>; Thu, 17 May 2001 18:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262206AbREQWyH>; Thu, 17 May 2001 18:54:07 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:23312 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S261943AbREQWxv>; Thu, 17 May 2001 18:53:51 -0400
Date: Thu, 17 May 2001 23:53:45 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: 2.2, 2.4 bug in sock_no_fcntl()/F_SETOWN? (fwd)
Message-ID: <Pine.LNX.4.30.0105172353170.13175-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Resend (no response first time)

---------- Forwarded message ----------
Date: Wed, 24 Jan 2001 21:09:09 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: 2.2, 2.4 bug in sock_no_fcntl()/F_SETOWN?


Hi,

Looking at the code for sock_no_fcntl() in net/core.c, I cannot specify
"0" as a value for F_SETOWN, unless I'm the superuser. I believe this to
be a bug, it stops de-registering an interest in SIGURG signals. Let me
know if you want a patch.

Cheers
Chris


