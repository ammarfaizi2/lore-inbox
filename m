Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269223AbRH0VsD>; Mon, 27 Aug 2001 17:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269318AbRH0Vrz>; Mon, 27 Aug 2001 17:47:55 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:49941 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S269223AbRH0Vrn>; Mon, 27 Aug 2001 17:47:43 -0400
From: volodya@mindspring.com
Date: Mon, 27 Aug 2001 17:50:21 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: linux-kernel@vger.kernel.org
Subject: NFS in 2.4.9
Message-ID: <Pine.LNX.4.20.0108271739400.15526-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have upgraded to 2.4.9 and NFS no longer works for me. I get
---------------------------------------------------------------
NFS: NFSv3 not supported.
nfs warning: mount version older than kernel
---------------------------------------------------------------
even though I upgraded to the most recent version of util-linux 
(2.11h) and when reading certain files programs lock up and the kernel
prints out the following messages:

nfs: server node4 not responding, still trying
nfs: server node4 not responding, still trying

However, node4 is fine (I can telnet in it) and seems to work ok. 
(node4 is running 2.4.7, with knfsd).

No oopses, etc..

                       Vladimir Dergachev

