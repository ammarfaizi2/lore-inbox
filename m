Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSLBPsb>; Mon, 2 Dec 2002 10:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264630AbSLBPsb>; Mon, 2 Dec 2002 10:48:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14187 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264629AbSLBPsa>; Mon, 2 Dec 2002 10:48:30 -0500
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] kexec-tools-1.8
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m11y5j2r9t.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
Date: 02 Dec 2002 08:54:55 -0700
Message-ID: <m1lm38xvow.fsf_-_@frodo.biederman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kexec-tools-1.8 is now available at:
http://www.xmission.com/~ebiederm/files/kexec/kexec-tools-1.8.tar.gz

Dave Hansen has a patch that allows /proc/iomem to export resources
above 4GB which is needed on machines on with > 4GB of RAM.

Changes:
- /proc/iomem is now parsed so the new kernels memory map should be correct.
- initrds are now actually read into memory so they should work, as well.

That should make kexec quite useable.

The syscall:
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec.diff
and the fixes
http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.48.x86kexec-hwfixes.diff
continue to apply to 2.5.50 so I have not updated them.  

The archive is at:
http://www.xmission.com/~ebiederm/files/kexec/

My apologies for not getting this sooner.  Along with the holidays I have been
battling a cold...

Eric
