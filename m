Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVESR0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVESR0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 13:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVESR0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 13:26:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:37873 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261174AbVESR0W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 13:26:22 -0400
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	when RT program dumps core]
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, kus Kusche Klaus <kus@keba.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1116509820.15866.28.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116509820.15866.28.camel@localhost.localdomain>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 19 May 2005 10:25:52 -0700
Message-Id: <1116523552.14229.64.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 09:37 -0400, Steven Rostedt wrote:

> The reason I'm asking this, is that RT tasks should not call yield,
> since it is pretty much meaningless, since an RT task won't yield to any
> task of lesser priority, and in Ingo's current kernel the yield will
> send a bug message if it was called by an RT task.

I've seen a RT yield warning on this yield while running the FUSYN
tests .. I can't imagine why it's there either.

Daniel 

