Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281671AbRKUISb>; Wed, 21 Nov 2001 03:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281672AbRKUISW>; Wed, 21 Nov 2001 03:18:22 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:47312 "EHLO
	mailout00.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281671AbRKUISH>; Wed, 21 Nov 2001 03:18:07 -0500
Date: 21 Nov 2001 08:47:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8DGB4I5Hw-B@khms.westfalen.de>
In-Reply-To: <20011121003304.A683@vger.timpanogas.org>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20011120.222203.58448986.davem@redhat.com> <davem@redhat.com> <20011121001639.A813@vger.timpanogas.org> <20011120.222203.58448986.davem@redhat.com> <20011121003304.A683@vger.timpanogas.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@vger.timpanogas.org (Jeff V. Merkey)  wrote on 21.11.01 in <20011121003304.A683@vger.timpanogas.org>:

> download pre7, apply my patch, and do the build.  I went back
> over how I did the build, and this is the result of the build
> if you have unpacked, patched, then run "make oldconfig."  If I
> do a "make dep" then this problem does not occur, and the build

Isn't that exactly the FAQ Keith points out every other day or so (usually  
because of a modprobe "symbol not found"), one of the design bugs that  
kbuild 2.5 fixes (i.e., the kernel does not notice when it needs to make  
dep, so kbuild 2.5 handles dependencies differently)?

MfG Kai
