Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268311AbUIBNeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268311AbUIBNeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 09:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268321AbUIBNeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 09:34:23 -0400
Received: from bos-gate2.raytheon.com ([199.46.198.231]:13500 "EHLO
	bos-gate2.raytheon.com") by vger.kernel.org with ESMTP
	id S268311AbUIBNeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 09:34:13 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q7
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Thomas Charbonnel <thomas@undata.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF8D80E555.AA8A5E5E-ON86256F03.00497F6B@raytheon.com>
From: Mark_H_Johnson@Raytheon.com
Date: Thu, 2 Sep 2004 08:33:27 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 09/02/2004 08:33:35 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I also looked briefly at find_first_bit since it appears in a number
>> of traces. Just curious, but the coding for the i386 version is MUCH
>> different in style than several other architectures (e.g, PPC64,
>> SPARC). Is there some reason why it is recursive on the x86 and a loop
>> in the others?
>
>what do you mean by recursive? It uses the SCAS (scan string) x86
>instruction.

Never mind. In bitops.c I misread "find_first_bit" (the call near the end)
as "find_next_bit" and thought there was recursion here.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

