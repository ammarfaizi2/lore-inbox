Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbSKRABe>; Sun, 17 Nov 2002 19:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261206AbSKRABd>; Sun, 17 Nov 2002 19:01:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46162 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261205AbSKRABc>; Sun, 17 Nov 2002 19:01:32 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [ANNOUNCE] kexec-tools-1.6 released
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 17:07:31 -0700
In-Reply-To: <1037148514.13280.97.camel@andyp>
Message-ID: <m1k7jb3flo.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The kernel interface has finally as stabilized enough I managed to put
some work into the user space side of things.

The new release is at:
http://www.xmission.com/~ebiederm/kexec-tools-1.6.tar.gz

The interface is now more like reboot, so you probably want to change
your shutdown scripts or use kexec --force.

And by default it now enters the kernel in 32bit mode so it should avoid
interrupt controller problems, and work for more people, in more strange
situations.

Eric
