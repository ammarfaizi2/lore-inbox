Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264311AbRFDPMu>; Mon, 4 Jun 2001 11:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264312AbRFDPMj>; Mon, 4 Jun 2001 11:12:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:36623 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S264311AbRFDPMT>; Mon, 4 Jun 2001 11:12:19 -0400
Date: Mon, 4 Jun 2001 11:13:03 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@vesta.nine.com>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: CONFIG_X86_UP_APIC undocumented
Message-ID: <Pine.LNX.4.33.0106041103440.25918-100000@vesta.nine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Eric!

For some reason CONFIG_X86_UP_APIC doesn't appear in your list of
undocumented symbols. You may need to adjust your checker. It is used in
2.4.5-ac7 kernel in arch/i386/config.in:

bool 'APIC support on uniprocessors' CONFIG_X86_UP_APIC

The entry for CONFIG_X86_UP_IOAPIC seems to talk both about APIC and
IO-APIC. Maybe it just needs splitting. But I'm leaving it to somebody
more competent in the matter.

It would also be nice to have some info about the difference between APIC
and IO-APIC and why only the former works on uniprocessor VIA boards.

-- 
Regards,
Pavel Roskin

