Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbSJRBFa>; Thu, 17 Oct 2002 21:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262697AbSJRBFa>; Thu, 17 Oct 2002 21:05:30 -0400
Received: from zero.aec.at ([193.170.194.10]:11279 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262679AbSJRBFa>;
	Thu, 17 Oct 2002 21:05:30 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Alexander Viro <viro@math.psu.edu>,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>,
       Mark Gross <markgross@thegnar.org>, Ulrich Drepper <drepper@redhat.com>,
       <linux-kernel@vger.kernel.org>,
       NPT library mailing list <phil-list@redhat.com>
Subject: Re: [patch] thread-aware coredumps, 2.5.43-C3
References: <200210081627.g98GRZP18285@unix-os.sc.intel.com>
	<Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain>
From: Andi Kleen <ak@muc.de>
Date: 18 Oct 2002 03:10:45 +0200
In-Reply-To: <Pine.LNX.4.44.0210171009240.12653-100000@localhost.localdomain>
Message-ID: <m33cr4pn56.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:


[...]

This is not directly related to mt coredumps, but for anybody hacking the 
core dumper:

it would be cool if error code/trapno were included in the coredump in some
elf note. It has always annoyed me that these were lost and they can
be very useful to diagnose crashes that are caused by kernel problems.

-Andi
