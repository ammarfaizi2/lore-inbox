Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318426AbSIKHBf>; Wed, 11 Sep 2002 03:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318428AbSIKHBf>; Wed, 11 Sep 2002 03:01:35 -0400
Received: from mx2.elte.hu ([157.181.151.9]:37851 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318426AbSIKHBd>;
	Wed, 11 Sep 2002 03:01:33 -0400
Date: Wed, 11 Sep 2002 09:12:01 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Thomas Molina <tmolina@cox.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Problem Status Report
In-Reply-To: <1031716821.1571.91.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209110911320.5546-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Sep 2002, Robert Love wrote:

> >    do_syslog lockup             open                  09 Sep 2002
> 
> This is fixed in 2.5-BK.

and it has nothing to do with do_syslog - that was a symbol mismatch.

the lockup was in sys_exit().

	Ingo

