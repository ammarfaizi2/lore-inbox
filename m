Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbTILNo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 09:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbTILNo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 09:44:28 -0400
Received: from dsl092-073-159.bos1.dsl.speakeasy.net ([66.92.73.159]:20749
	"EHLO yupa.krose.org") by vger.kernel.org with ESMTP
	id S261621AbTILNo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 09:44:27 -0400
To: linux-kernel@vger.kernel.org
Subject: NVIDIA proprietary driver problem
X-Home-Page: http://www.krose.org/~krose/
From: Kyle Rose <krose+linux-kernel@krose.org>
Organization: krose.org
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 12 Sep 2003 09:44:25 -0400
Message-ID: <87u17if7eu.fsf@nausicaa.krose.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Rational FORTRAN,
 i386-debian-linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Man, I'm just chock *full* o'problems this week, aren't I?

Under 2.6.0-test5, loading NVIDIA proprietary driver (patched with the
stuff at http://www.minion.de/nvidia.html) reports:

Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Can't find an IRQ for your NVIDIA card!
Sep 11 23:37:57 nausicaa kernel: 0: nvidia: Please check your BIOS settings.
Sep 11 23:37:57 nausicaa kernel: 0: nvidia: [Plug & Play OS   ] should be set to NO
Sep 11 23:37:57 nausicaa kernel: 0: nvidia: [Assign IRQ to VGA] should be set to YES

Same driver source does not have this effect under test4, with
approximately the same config (i.e., make oldconfig).

Yeah, I cleaned everything appropriately and rebuilt for test5.  Bzzt.

(FWIW, I do not have the referenced options in my BIOS, but I strongly
suspect that isn't the problem, anyway.)

Cheers,
Kyle
