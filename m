Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265547AbSJXQoB>; Thu, 24 Oct 2002 12:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSJXQnK>; Thu, 24 Oct 2002 12:43:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23601 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265543AbSJXQmZ>; Thu, 24 Oct 2002 12:42:25 -0400
To: Ville Herva <vherva@niksula.hut.fi>
Cc: James Stevenson <james@stev.org>, ebiederm@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
References: <20021023130251.GF25422@rdlg.net>
	<1035411315.5377.8.camel@god.stev.org>
	<20021024101126.GQ147946@niksula.cs.hut.fi>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Oct 2002 10:46:39 -0600
In-Reply-To: <20021024101126.GQ147946@niksula.cs.hut.fi>
Message-ID: <m1znt3rdhs.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva <vherva@niksula.hut.fi> writes:

> On Wed, Oct 23, 2002 at 11:15:14PM +0100, you [James Stevenson] wrote:
> > 
> > As to load a module you must be root and if you are root you
> > can read / write disks. Thus you could recompile your own kernel
> > install it try to force a crash or a reboot which is not hard as root
> > and the person may not even notice that the kernel has grown by a few
> > bytes after the crash.
> 
> Which is why some people configure kernels not to support installing modules
> and only use read-only media (e.g. CD-R) for booting. Sure, there's still
> the /dev/kmem hole, but this closes 2 classes of attacks - loading rootkit
> module and booting with a hacked kernel in straight-forward way.
> 
> BTW, this might be a reason to make kexec syscall to be a config option (if
> it isn't already.)

It already is a config option.

Eric
