Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbSJBSGD>; Wed, 2 Oct 2002 14:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262513AbSJBSGD>; Wed, 2 Oct 2002 14:06:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:43017
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262515AbSJBSGC>; Wed, 2 Oct 2002 14:06:02 -0400
Subject: Re: [PATCH] Re: Capabilities-related change in 2.5.40
From: Robert Love <rml@tech9.net>
To: Chris Wright <chris@wirex.com>
Cc: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20021002094417.D26557@figure1.int.wirex.com>
References: <20021001164907.GA25307@nevyn.them.org>
	 <20021001134552.A26557@figure1.int.wirex.com>
	 <20021001211210.GA8784@nevyn.them.org>
	 <20021002003817.B26557@figure1.int.wirex.com>
	 <20021002132331.GA17376@nevyn.them.org>
	 <1033569212.24108.20.camel@phantasy>
	 <20021002094417.D26557@figure1.int.wirex.com>
Content-Type: text/plain
Organization: 
Message-Id: <1033582255.24476.52.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 02 Oct 2002 14:10:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 12:44, Chris Wright wrote:

> kernel/sched.c::static inline task_t *find_process_by_pid...
> 
> Guess that won't work w/out more changes.  Perhaps it's simpler/safer
> to be just be explicit in this case.

>From 2.5.40:

        static inline task_t *find_process_by_pid(pid_t pid)
        {
        	return pid ? find_task_by_pid(pid) : current;
        }

should work :)

	Robert Love

