Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbTJTOdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbTJTOdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:33:08 -0400
Received: from main.gmane.org ([80.91.224.249]:44722 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262576AbTJTOdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:33:05 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Mon, 20 Oct 2003 16:32:59 +0200
Message-ID: <yw1x8yngj7xg.fsf@users.sourceforge.net>
References: <20031020141512.GA30157@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:fU+dOB57epIDVSqJJNalKH+Rhug=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karol Kozimor <sziwan@hell.org.pl> writes:

> Suspending and resuming from S1 disables ACPI interrupts for my machine
> (ASUS L3800C laptop). No further interrupts and events are generated,
> /proc/interrupts shows no change w.r. to ACPI. This happens regardless of
> whether the specific IRQ is shared or not.

I've got an Asus M2400E laptop, and have seen similar things.  After a
suspend, the extra buttons (I use them to fire up programs) stop
working.  Normally, they will generate an ACPI event, that is
processed by acpid etc.  After a suspend, each button will work once.
If I then close and open the lid, they will work one more time, and so
on.  Any way I can help?

-- 
Måns Rullgård
mru@users.sf.net

