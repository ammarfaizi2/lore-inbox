Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUFYPja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUFYPja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 11:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266772AbUFYPja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 11:39:30 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:31596 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266768AbUFYPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 11:39:29 -0400
Message-ID: <20040625153929.79516.qmail@web81307.mail.yahoo.com>
Date: Fri, 25 Jun 2004 08:39:29 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: RE: [PATCH] 2.6.7-mm2: CONFIG_SERIO_I8042 broken on non-{i386,x86_64}
To: Olof Johansson <olof@austin.ibm.com>, LKML <linux-kernel@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> It seems that input-serio-dynamic-allocation.patch in 2.6.7-mm2 broke at
> least ppc64 builds.
> 
> Attached patch applies on top of it. I don't like the way it's coded
> myself, maybe the #include "i8042.h" should be moved below the
> declarations instead? I'm not too happy with that either though. Feel
> free to solve it some other way. :)

Yes, the include should be moved back where it was before. I will send
updated patches soon (Andrew showed me set of cross-compilers so this
time there should be no silly breakages on my part).

--
Dmitry
