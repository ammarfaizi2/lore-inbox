Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVERPKu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVERPKu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 11:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVERPGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 11:06:00 -0400
Received: from main.gmane.org ([80.91.229.2]:3210 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262247AbVERPFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 11:05:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Soboroff <isoboroff@acm.org>
Subject: Re: ACPI S3/APM suspend
Date: Wed, 18 May 2005 10:59:47 -0400
Message-ID: <9cfzmusbmvw.fsf@rogue.ncsl.nist.gov>
References: <9cfvf5gel2l.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: rogue.ncsl.nist.gov
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:ScJg5T+YY3qGpXD+9xa2SgzVmrM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Soboroff <isoboroff@acm.org> writes:

> I recently reinstalled my laptop (Fujitsu P2110) with RHEL4, and I
> found that neither ACPI S3 or APM suspend (booting with acpi=off) work
> reliably with their stock kernel (a 2.6.9 derivative).  Sometimes
> resuming works, but more often the computer locks up, or the keyboard
> doesn't function respond.

Just tried with 2.6.11.10 using ACPI.  On resume, the mouse doesn't
respond (there isn't even a cursor).  If I C-A-Backspace out of X, GDM
needs to be specially HUP'd to restart.  But the mouse still doesn't
work.

This was one of the failure modes in the RHEL 2.6.9-5.0.5 kernel.  (I
know, I know, "ask RH for support", but they don't seem to have any of
the ACPI or APM suspend bugs in their bugzilla anywhere near
resolved.)

Ian


