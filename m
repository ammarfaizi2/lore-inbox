Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262909AbVF3IeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbVF3IeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262917AbVF3IeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:34:10 -0400
Received: from ns.suse.de ([195.135.220.2]:35480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262909AbVF3IeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:34:07 -0400
From: Gernot Payer <gpayer@suse.de>
To: Roland McGrath <roland@redhat.com>
Subject: Re: Patch to disarm timers after an exec syscall
Date: Thu, 30 Jun 2005 10:34:06 +0200
User-Agent: KMail/1.6.2
References: <200506291850.j5TIo72x032190@magilla.sf.frob.com>
In-Reply-To: <200506291850.j5TIo72x032190@magilla.sf.frob.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506301034.06372.gpayer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 20:50, Roland McGrath wrote:
> In the current code, de_thread already calls exit_itimers to address
> exactly this issue.  Can someone please send me the test case that
> demonstrates this is not working right?

This test case can be found here:

http://cvs.sourceforge.net/viewcvs.py/posixtest/posixtestsuite/conformance/interfaces/timer_create/9-1.c?view=markup

But as already mentioned in this thread, this test case is wrong.

> Thanks,
> Roland

mfg
Gernot
