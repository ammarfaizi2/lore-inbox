Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSKRFkM>; Mon, 18 Nov 2002 00:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSKRFkM>; Mon, 18 Nov 2002 00:40:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2131 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261365AbSKRFkL>; Mon, 18 Nov 2002 00:40:11 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
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
Subject: Re: [ANNOUNCE] kexec-tools-1.6 released
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 22:46:44 -0700
In-Reply-To: <m1k7jb3flo.fsf_-_@frodo.biederman.org>
Message-ID: <m1el9j2zwb.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> The kernel interface has finally as stabilized enough I managed to put
> some work into the user space side of things.
> 
> The new release is at:
> http://www.xmission.com/~ebiederm/kexec-tools-1.6.tar.gz

Make that:
http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.6.tar.gz
And the latest patches can be found at:

http://www.xmission.com/~ebiederm/files/kexec/

The basic breakout is 
linux-2.4.47.x86kexec.diff is the core patch.
linux-2.4.47.x86kexec-hwfixes.diff 
       applies on top and is has some hardware fixes that
       shutdown kernel code, and make things work better.
       Mostly this is the code to get SMP to shutdown properly.

And it looks like .48 is out so I need to do another patch update.

Eric
