Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273738AbRIXCFG>; Sun, 23 Sep 2001 22:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273739AbRIXCE4>; Sun, 23 Sep 2001 22:04:56 -0400
Received: from blount.mail.mindspring.net ([207.69.200.226]:44824 "EHLO
	blount.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273738AbRIXCEp>; Sun, 23 Sep 2001 22:04:45 -0400
Subject: Re: Preempt kernel and mc issue?
From: Robert Love <rml@ufl.edu>
To: Steve Kieu <haiquy@yahoo.com>
Cc: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010924015137.659.qmail@web10408.mail.yahoo.com>
In-Reply-To: <20010924015137.659.qmail@web10408.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.22.08.08 (Preview Release)
Date: 23 Sep 2001 22:05:25 -0400
Message-Id: <1001297131.8416.9.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-09-23 at 21:51, Steve Kieu wrote:
> I got randomly mc hang with preempt enabled kernel.
> How could it  possibly be? 
> 
> Kernel 2.4.10-pre15 and it happened both in light load
> and heavy load. Anyway I have not tested this kernel
> without preempt yet, so I can not say it is because
> preempt feature but it is likely to be . Under heavy
> load all other programms behaves so well !

Try this patch
http://tech9.net/rml/linux/patch-rml-2.4.10-preempt-ptrace-and-jobs-fix-2

It has not been merged into the 2.4.10-pre15 patch.  Please report back
if it fixes your issue.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

