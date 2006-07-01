Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWGACsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWGACsc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 22:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWGACsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 22:48:32 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:34160 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751153AbWGACsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 22:48:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=ggP2/VMQ/zVDfTcNhL858PyBtjNOtTOOBCD6f/+k/V6yBogfgs3zoEbXg7eUcclBFXqVq0DOa8uglNBWuMkCAXSuORAlPkC92IrBwBBYMzRrbOhXuwnAdx0nrMXcJ8TSwiFTuqOvIYwOfR8JBY0FlzLgmxulIvlQdVb9tsDeEz8=  ;
Message-ID: <20060701024831.47290.qmail@web31812.mail.mud.yahoo.com>
Date: Fri, 30 Jun 2006 19:48:31 -0700 (PDT)
From: Luben Tuikov <ltuikov@yahoo.com>
Reply-To: ltuikov@yahoo.com
Subject: Re: [PATCH] sched.h: increment TASK_COMM_LEN to 20 bytes
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060630183744.310f3f0d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Andrew Morton <akpm@osdl.org> wrote:
> Luben Tuikov <ltuikov@yahoo.com> wrote:
> >
> > > We do occasionally hit task_struct.comm[] truncation, when people use
> > > "too-long-a-name%d" for their kernel thread names.  But we seem to manage.
> > 
> > It would be especially helpful if you want to name a task thread
> > the NAA IEEE Registered name format (16 chars, globally unique), for things
> > like FC, SAS, etc.  This way you can identify the task thread with
> > the device bearing the NAA IEEE name.
> > 
> > Currently just last character is cut off, since TASK_COMM_LEN is 15+1.
> > 
> > I think incrementing it would be a good thing, plus other things
> > may want to represent 8 bytes as a character array to be the name
> > of a task thread.
> 
> OK, that's a reason.  Being able to map a kernel thread onto a particular
> device is useful.

OK, great.

   Luben

