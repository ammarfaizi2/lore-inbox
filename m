Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262852AbTCSAOR>; Tue, 18 Mar 2003 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262846AbTCSAOR>; Tue, 18 Mar 2003 19:14:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:40361 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262852AbTCSAOP>;
	Tue, 18 Mar 2003 19:14:15 -0500
Date: Tue, 18 Mar 2003 16:18:52 -0800
From: Andrew Morton <akpm@digeo.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: mikpe@csd.uu.se, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: apic-to-drivermodel conversion
Message-Id: <20030318161852.41a703a4.akpm@digeo.com>
In-Reply-To: <20030318202858.GA154@elf.ucw.cz>
References: <20030318202858.GA154@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Mar 2003 00:24:50.0131 (UTC) FILETIME=[F429F230:01C2EDAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> This converts apic code to use driver model. It is neccessary for S3
> when you are using apic. 

Seems to be missing something.

arch/i386/kernel/apm.c: In function `suspend':
arch/i386/kernel/apm.c:1242: warning: implicit declaration of function `device_suspend'
arch/i386/kernel/apm.c:1242: `SUSPEND_POWER_DOWN' undeclared (first use in this function)
arch/i386/kernel/apm.c:1242: (Each undeclared identifier is reported only once
arch/i386/kernel/apm.c:1242: for each function it appears in.)
arch/i386/kernel/apm.c:1264: warning: implicit declaration of function `device_resume'
arch/i386/kernel/apm.c:1264: `RESUME_POWER_ON' undeclared (first use in this function)
arch/i386/kernel/apm.c: In function `check_events':
arch/i386/kernel/apm.c:1378: `RESUME_POWER_ON' undeclared (first use in this function)

