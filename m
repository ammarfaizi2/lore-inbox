Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSIFOa4>; Fri, 6 Sep 2002 10:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318649AbSIFOa4>; Fri, 6 Sep 2002 10:30:56 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19727
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318643AbSIFOa4>; Fri, 6 Sep 2002 10:30:56 -0400
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: Robert Love <rml@tech9.net>
To: Dan Aloni <da-x@gmx.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, akpm@zip.com.au
In-Reply-To: <20020906092829.GA32379@callisto.yi.org>
References: <20020902003318.7CB682C092@lists.samba.org> 
	<20020906092829.GA32379@callisto.yi.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 06 Sep 2002 10:35:24 -0400
Message-Id: <1031322928.940.41.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-06 at 05:28, Dan Aloni wrote:

> task_t, anyone?

I actually like task_t, and it is my lone typedef exception, but maybe I
am the exception...

My real complaint against typedefs (and list_t in particular) is their
inconsistent use.  I think we have done a good job universally using
task_t vs struct task_struct, and thus its not an issue to keep it... 
On the other hand, I would not scream too loudly over its removal.

Anyhow, I think any change should be ack'ed by Ingo because its his code
and he deals with it a disappropriately large amount of the time.

	Robert Love

