Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318716AbSIKLOC>; Wed, 11 Sep 2002 07:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318719AbSIKLOC>; Wed, 11 Sep 2002 07:14:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:11673 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318716AbSIKLN7>;
	Wed, 11 Sep 2002 07:13:59 -0400
Date: Wed, 11 Sep 2002 13:24:21 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Read-Copy Update 2.5.34
In-Reply-To: <20020911164940.C28198@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Sep 2002, Dipankar Sarma wrote:

> Ingo, it will be nice to have your comments on this, specially since it
> touches the scheduler.

i dont really understand why it has to change the scheduler. You want a
facility to force a reschedule on any given CPU, correct?

	Ingo

