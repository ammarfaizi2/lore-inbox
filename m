Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262201AbTB0Iwu>; Thu, 27 Feb 2003 03:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262289AbTB0Iwu>; Thu, 27 Feb 2003 03:52:50 -0500
Received: from elixir.e.kth.se ([130.237.48.5]:10 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S262201AbTB0Iwu>;
	Thu, 27 Feb 2003 03:52:50 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.62 + ide + netboot
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 27 Feb 2003 10:03:08 +0100
Message-ID: <yw1x8yw2umcz.fsf@manganonaujakasit.e.kth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm having some problems with booting linux 2.5.62 over network on an
Alpha system with aboot 0.9.

The problem is that if the uncompressed kernel is bigger than ~2.6 MB
the kernel will not boot, but instead falls back to SRM with a message
stating that "kernel stack invalid".  Does this mean that the stack
was overwritten with kernel code?

Now, the only way I can make the kernel small enough to boot is by
leaving out IDE support.  This would be fine if weren't for the fact
that IDE can't be built as modules.  I don't have the exact errors
here, but I can send them on request.

What needs to be changed to make more room for the kernel image?  Is
it aboot that defines this, or is it somewhere in the kernel sources?

Is anyone fixing IDE as modules?  This is broken in 2.4 kernels too.

-- 
Måns Rullgård
mru@users.sf.net
