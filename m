Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266101AbSLCH3I>; Tue, 3 Dec 2002 02:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266112AbSLCH3I>; Tue, 3 Dec 2002 02:29:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9836 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266101AbSLCH3I>; Tue, 3 Dec 2002 02:29:08 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       "Klingaman, Aaron L" <aaron.l.klingaman@intel.com>
Subject: Re: [ANNOUNCE] kexec-tools-1.8
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
	<m1r8d1xcap.fsf_-_@frodo.biederman.org> <3DEC1758.8030302@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Dec 2002 00:35:02 -0700
In-Reply-To: <3DEC1758.8030302@us.ibm.com>
Message-ID: <m18yz7y2qh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> It booted on my first try, even with the 64-bit /proc/iomem changes. I tried it
> on machines with 16GB and 1GB of RAM.  (insert clapping here)

Thanks.  The code for reading /proc/iomem was a modeled after 
Andy Pfiffer's work, and your earlier patch.  I just cleaned them
up and integrated it cleanly with my existing code base.

I guess that means I should shake off the bit rot and resubmit
to Linus.

Eric
