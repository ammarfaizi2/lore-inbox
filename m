Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbTFRWhR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbTFRWhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:37:17 -0400
Received: from 66-122-194-202.ded.pacbell.net ([66.122.194.202]:8126 "HELO
	mail.keyresearch.com") by vger.kernel.org with SMTP id S265579AbTFRWhO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:37:14 -0400
Subject: Re: [2.5.72] Oops on x86_64 running 32-bit code
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030618224516.GF3543@wotan.suse.de>
References: <1055976017.25153.74.camel@serpentine.internal.keyresearch.com>
	 <20030618224516.GF3543@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1055976671.25153.80.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 18 Jun 2003 15:51:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 15:45, Andi Kleen wrote:

> Looks quite garbled. Is it reproducible?

Not yet.  I'll let you know if I see anything.

On an unrelated note, the trouble with running BK in 32-bit mode seems
to be back:

~ $ bk help
system: No child processes
system: No child processes
less: Bad file descriptor
system: No child processes

This time, there are no syslog errors or other reports to indicate
what's up.  I can't strace it to see where it's dying, because 64-bit
strace won't handle 32-bit code.

	<b

