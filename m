Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314207AbSDRAKT>; Wed, 17 Apr 2002 20:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314208AbSDRAKS>; Wed, 17 Apr 2002 20:10:18 -0400
Received: from zero.tech9.net ([209.61.188.187]:12548 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314207AbSDRAKS>;
	Wed, 17 Apr 2002 20:10:18 -0400
Subject: Re: binding a process to a processor
From: Robert Love <rml@tech9.net>
To: Lee Chin <leechinus@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418000449.64275.qmail@web14305.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 20:10:22 -0400
Message-Id: <1019088622.5409.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-17 at 20:04, Lee Chin wrote:
> How do I bind a user process to a processor?

In 2.5, there is the system call sched_setaffinity.  It is rather new so
your libraries do not support it - see example code and headers at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/cpu-affinity

For 2.4, there is not yet such an interface.  At the above URL, you can
find a proc-based and a syscall-based interface for setting and
retrieving affinity.

	Robert Love

