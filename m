Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318246AbSIGPKj>; Sat, 7 Sep 2002 11:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSIGPKj>; Sat, 7 Sep 2002 11:10:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22667 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318246AbSIGPKj>;
	Sat, 7 Sep 2002 11:10:39 -0400
Date: Sat, 7 Sep 2002 17:17:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: pwaechtler@mac.com
Cc: Amos Waterland <apw@us.ibm.com>, <golbi@mat.uni.torun.pl>,
       <linux-kernel@vger.kernel.org>, Jakub Jelinek <jakub@redhat.com>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] POSIX message queues
In-Reply-To: <B547AE30-C26B-11D6-87AD-00039387C942@mac.com>
Message-ID: <Pine.LNX.4.44.0209071716460.17119-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Sep 2002 pwaechtler@mac.com wrote:

> OTOH I can't see a _big_ problem when a process with sufficient
> permissions can trash the message queues - otherwise I wonder why file
> permissions are granted "per user" and not "per process".

yes - furthermore, processes from the same user can 'trash' queues anyway,
via ptrace() or mmaping /proc.

	Ingo

