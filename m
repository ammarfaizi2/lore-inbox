Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWJFDFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWJFDFE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 23:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbWJFDFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 23:05:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:21088 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751080AbWJFDE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 23:04:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tizdRNL0dWeOCx1C/w4pBaj1VgVYVDOCcr2LShfOIigwTmC8pemCkKudVEtoGwayckVENAZ/rFhrG79QuqUHn3uAEN8Hj/k9/NGWWNMGKMFYbp/BRbMTE/EaHk2qcpUSLs0bkfuilxriiXooG/qC2LVWxrlbA9Vb9JmbkCCdHeQ=
Message-ID: <9a0545880610052004o78433b52u24154e8ba1080bb3@mail.gmail.com>
Date: Thu, 5 Oct 2006 20:04:56 -0700
From: "Steve Hindle" <mech422@gmail.com>
To: "David Chinner" <dgc@sgi.com>
Subject: Re: PROBLEM: Hardlock with 2.6.18-mm3 on Abit AI7, ICH5 + EXT3/XFS, SATA under heavy I/O load
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I confirmed I get the exact same behavior with 2.6.18-mm3 and ext3..
So I don't think XFS is the problem.

Its _really_ annoying that the box is more stable under windows then
linux :-(  Is there anything I can do to help narrow it down?  The
configs are the same as in the previous post, except this time I
booted with 2.6.18-mm3.  I suspect a SATA problem, but I'm unsure what
to test?  should I try booting with acpi=off? or maybe disabling
(l?)apic stuff?  I don't have any idea what boot options are
relavent...Given it only flakes under 'heavy' load, could it be
interrupt related?

Steve
