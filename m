Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030793AbWKOWys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030793AbWKOWys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 17:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031017AbWKOWyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 17:54:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34004 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030793AbWKOWyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 17:54:47 -0500
Date: Wed, 15 Nov 2006 23:54:29 +0100
From: Pavel Machek <pavel@suse.cz>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86_64: Move cpu long mode verification code to common file (was Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup)
Message-ID: <20061115225429.GD3722@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <200611131822.44034.ak@suse.de> <20061115210728.GE9039@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061115210728.GE9039@in.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It would be much better if this least this CPUID code was in a common shared 
> > file with head.S

> 
> Pleaese find attached the patch which moves verify_cpu code to a
> single file arch/x86_64/kernel/verify_cpu.S and this file is included
> by all to do the cpu long mode and SSE checks.

Looks ok to me on quick look...

> @@ -0,0 +1,103 @@
> +/*
> + *
> + *	verify_cpu.S
> + *
> + * 	14 Nov 2006  Vivek Goyal: Created the file

Could we get copyright/GPL here, instead?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
