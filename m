Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTJZOIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 09:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263172AbTJZOIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 09:08:37 -0500
Received: from main.gmane.org ([80.91.224.249]:50078 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263166AbTJZOIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 09:08:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Missing ACPI interrupts/events after S3 suspend
Date: Sun, 26 Oct 2003 15:08:32 +0100
Message-ID: <yw1x4qxwgkgv.fsf@kth.se>
References: <20031026133510.GA19227@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:HV5PG+cI6mlKfiSNGfbJrnVuaQw=
Cc: acpi-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett <mjg59@srcf.ucam.org> writes:

> Using 2.6.0-test9 if I do an S3 suspend, then when the machine comes 
> back pressing the power button generates no ACPI events or interrupts. 
> Other events (sleep button, lid switch, plugging/unplugging AC adapter) 
> still work.

What model is your machine?  My Asus M2400E behaves similarly.  After
echo -n mem > /sys/power/state, all the extra buttons stop working,
except that each one will work once after closing and opening the
lid.  Another lid cycle makes them work one more time.

-- 
Måns Rullgård
mru@kth.se

