Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSLQQpb>; Tue, 17 Dec 2002 11:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSLQQpb>; Tue, 17 Dec 2002 11:45:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5809 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S264673AbSLQQpa>; Tue, 17 Dec 2002 11:45:30 -0500
Date: Tue, 17 Dec 2002 16:54:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171556110.1460-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212171653310.1547-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Hugh Dickins wrote:
> whereas now I can read a 0 there (and perhaps you should be
> using get_zeroed_page rather than __get_free_page?).

Sorry, yes, you are using get_zeroed_page for the one that needs it.

Hugh

