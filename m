Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263016AbTDBOeR>; Wed, 2 Apr 2003 09:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263017AbTDBOeR>; Wed, 2 Apr 2003 09:34:17 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53000 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S263016AbTDBOeQ>;
	Wed, 2 Apr 2003 09:34:16 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linas@austin.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ptrace patch fails stress testing 
In-reply-to: Your message of "02 Apr 2003 12:49:48 +0100."
             <1049284187.16276.32.camel@dhcp22.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Apr 2003 00:45:31 +1000
Message-ID: <28174.1049294731@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-01 at 19:22, linas@austin.ibm.com wrote:
> The problem appears to be that task->mm is dereferenced without 
> looking to see if mm is NULL.  e.g. in the sched.h in the 
> is_dumpable() macro, we have task->mm->dumpable .  I'm sitting
> in front of a KDB session and I'm clearly looking at task->mm
> which is NULL. 

Sorry, KDB is an illegal kernel patch.  Linus has spoken, the kernel
does not need debuggers.

All right, assume a smiley there.

