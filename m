Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262054AbTDAF6d>; Tue, 1 Apr 2003 00:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTDAF6d>; Tue, 1 Apr 2003 00:58:33 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:20406 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262054AbTDAF6d>; Tue, 1 Apr 2003 00:58:33 -0500
Date: Tue, 1 Apr 2003 01:06:51 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200304010606.h3166pr27274@devserv.devel.redhat.com>
To: "Paul Clements (home)" <pclements@alltel.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: unexporting sys_call_table a good idea?
In-Reply-To: <mailman.1049173681.3377.linux-kernel2news@redhat.com>
References: <mailman.1049173681.3377.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [...] it is,
> rather than being able to simply compile an external module (which
> disables ptrace) and load it on affected systems, I am forced to
> recompile an entire kernel, install it on the affected systems, and
> reboot them all...
> 
> Thanks,
> Paul

This is fallacy. How is exporting syscall table going to help you?
You still have to recompile entire kernel, install it on the
affected systems, and reboot them all, and only then you can
use your module. Wouldn't it be easier just to add a sysctl
which disables ptrace, instead?

-- Pete
