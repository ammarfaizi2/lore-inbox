Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263089AbUEFVmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263089AbUEFVmH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 17:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263095AbUEFVmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 17:42:06 -0400
Received: from emess.mscd.edu ([147.153.170.17]:6092 "EHLO emess.mscd.edu")
	by vger.kernel.org with ESMTP id S263089AbUEFVl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 17:41:58 -0400
From: Steve Beaty <beaty@emess.mscd.edu>
Message-Id: <200405062141.i46LfYVg017800@emess.mscd.edu>
Subject: Re: sigaction, fork, malloc, and futex
To: root@chaos.analogic.com
Date: Thu, 6 May 2004 15:41:34 -0600 (MDT)
Cc: beaty@emess.mscd.edu (Steve Beaty), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0405041928170.14876@chaos> from "Richard B. Johnson" at May 04, 2004 07:37:50 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure buggy code. There are only a few things you can do from
> a signal handler and I'm fairly sure fork() isn't one of them.

	well, one should only set values and deal with them somewhere in
	signal handlers, but...

> Did you just invent this as a way of concatenating system calls
> to see what works? Surely you don't have a program that does this
> do you?

	well, yes, but it is a classroom assignment so not "real" code.
	the assignment is to create a simulated disk drive (a process) via
	a "system call" that signals a "kernel".  perhaps we should really
	fork and exec...

-- 
Dr. Steve Beaty (B80)                                 Associate Professor
Metro State College of Denver                        beaty@emess.mscd.edu
VOX: (303) 556-5321                                 Science Building 134C
FAX: (303) 556-5381                         http://clem.mscd.edu/~beatys/
