Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132835AbRDQTdy>; Tue, 17 Apr 2001 15:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRDQTdP>; Tue, 17 Apr 2001 15:33:15 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:143 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132844AbRDQTch>; Tue, 17 Apr 2001 15:32:37 -0400
Message-ID: <3ADC989F.CDC380B5@uow.edu.au>
Date: Tue, 17 Apr 2001 12:25:19 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Hockin <thockin@isunix.it.ilstu.edu>
CC: Rusty Russell <rusty@rustcorp.com.au>, npollitt@engr.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Process pinning
In-Reply-To: <m14nIRX-001RovC@mozart> from "Rusty Russell" at Apr 11, 2001 09:05:47 PM <200104171617.LAA06660@isunix.it.ilstu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> 
> > disallowed CPU on which it is already running.  And even a non-RT
> > process will stick on its disallowed CPU as long as nothing else runs
> > there.
> 
> are we going to keep the cpus_allowed API?  If we want the (IMHO) more
> flexible sysmp() API - I'll finish the 2.4 port.  If we are going to keep
> cpus_allowed - I'll just abandon pset and sysmp.
> 
> Personally, I like sysmp() and the pset tools better, perhaps with a /proc
> extension to it.

http://www.uow.edu.au/~andrewm/linux/cpus_allowed.patch
