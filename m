Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261886AbSJNJAm>; Mon, 14 Oct 2002 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSJNJAl>; Mon, 14 Oct 2002 05:00:41 -0400
Received: from s2.org ([195.197.64.39]:48055 "EHLO kalahari.s2.org")
	by vger.kernel.org with ESMTP id <S261886AbSJNJAl>;
	Mon, 14 Oct 2002 05:00:41 -0400
To: linux-kernel@vger.kernel.org
Subject: Known problem in 2.5.42 with IO-APIC and VIA KT400/VT8235?
From: Jarno Paananen <jpaana@s2.org>
Date: 14 Oct 2002 12:06:32 +0300
Message-ID: <m3hefpwfs7.fsf@kalahari.s2.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if I enable CONFIG_X86_UP_IOAPIC in 2.5.42 with ASUS A7V8X
motherboard using VIA KT400 northbridge and VT8235 southbridge, the
kernel freezes right after uncompressing without printing
anything. Just turning off this option makes it boot correctly. The
BIOS has option to use PIC or APIC and is set to APIC. MPS version
can not be set.

The same option "works" in 2.4.20-pre10, ie. it doesn't crash, but
doesn't use APIC IRQs either.

Is this a known problem? Any ideas on how to debug this?

// Jarno
