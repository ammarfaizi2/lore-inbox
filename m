Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTLLOUb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264913AbTLLOUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:20:31 -0500
Received: from main.gmane.org ([80.91.224.249]:17825 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264902AbTLLOUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:20:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: PROBLEM: floppy motor spins when floppy module not installed
Date: Fri, 12 Dec 2003 15:18:03 +0100
Message-ID: <yw1xd6auyvac.fsf@kth.se>
References: <16345.51504.583427.499297@l.a>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:MMq1kHz1KT8KQDmBJ8FhhqEfz6g=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale Mellor <dale@dmellor.dabsol.co.uk> writes:

> 1. Floppy motor spins when floppy module not installed.

It's a known problem.  Some broken BIOSes don't turn off the motor
after probing for a disk.  One solution is to change the boot priority
in the BIOS settings so the hard disk is tried before floppy.  If you
ever need to boot from a floppy, you can change it back.

-- 
Måns Rullgård
mru@kth.se

