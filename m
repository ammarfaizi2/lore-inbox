Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbTAEBpc>; Sat, 4 Jan 2003 20:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262418AbTAEBpb>; Sat, 4 Jan 2003 20:45:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27967 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262414AbTAEBpb>; Sat, 4 Jan 2003 20:45:31 -0500
To: tomlins@cam.org
CC: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.54: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
References: <fa.efrhc1v.46m3b3@ifi.uio.no> <fa.jrc2dtv.1n26pa1@ifi.uio.no>
	<20030104232405.8A80FE7B6@oscar.casa.dyndns.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2003 18:53:00 -0700
In-Reply-To: <20030104232405.8A80FE7B6@oscar.casa.dyndns.org>
Message-ID: <m1fzs8jrb7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> writes:

> Just so you do not feel that kexec (.52 rewrite) is always failing in 
> 2.5.54 - it not.  I am using it for most of my boots here.  Aside from
> an intermittant hang starting usb, its worked very well.  I have not 
> installed any of your other patches.  (ie. 2.5.54+kexec+myownpatch)

Thanks, I think.

It good except that it make mean the problem is harder to reproduce,
making debugging harder.

If you are not doing SMP, UP-IOAPIC or > 4GB of ram the other patches
should not be an issue.

Eric
