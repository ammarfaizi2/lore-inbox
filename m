Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTJLJCb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 05:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbTJLJCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 05:02:31 -0400
Received: from pop.gmx.de ([213.165.64.20]:34974 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263435AbTJLJCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 05:02:31 -0400
X-Authenticated: #14349625
Message-Id: <5.2.1.1.2.20031012105054.01e34bc8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 12 Oct 2003 10:52:52 +0200
To: Manfred Spraul <manfred@colorfullife.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <3F88FB90.7080801@colorfullife.com>
References: <5.2.1.1.2.20031012060658.01e3b840@pop.gmx.net>
 <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
 <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
 <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net>
 <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
 <5.2.1.1.2.20031012060658.01e3b840@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:58 AM 10/12/2003 +0200, Manfred Spraul wrote:
>Could you try the attached patch?
>It updates the end of stack detection to handle unaligned stacks.

Works fine.  (modulo moving kstack_end above ASSEMBLY)

         Thanks,

         -Mike 

