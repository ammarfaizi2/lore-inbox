Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263887AbUDVJZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbUDVJZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 05:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263889AbUDVJZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 05:25:26 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:1199 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S263887AbUDVJZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 05:25:21 -0400
Subject: Re: [PATCH] s390 (7/9): oprofile for s390.
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.11   July 24, 2002
Message-ID: <OF139039C9.0CD544AD-ONC1256E7E.00310DE4-C1256E7E.0033BA72@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 22 Apr 2004 11:25:00 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.0.2CF2|July 23, 2003) at
 22/04/2004 11:25:01
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





> Could you also delete unrelated lines from arch/s390/oprofile/Makefile.
>
> > +++ linux-2.6-s390/arch/s390/oprofile/Makefile           Wed Apr 21
20:25:32 2004
> > +oprofile-y                                              :=
$(DRIVER_OBJS) init.o
> > +#oprofile-$(CONFIG_X86_LOCAL_APIC)          += nmi_int.o
op_model_athlon.o \
> > +
op_model_ppro.o op_model_p4.o
> > +#oprofile-$(CONFIG_X86_IO_APIC)                         +=
nmi_timer_int.o
>
> The X86 stuff should go away.

Ok, just removed this from my patch. Anything else before I re-sent
it to Andrew?

blue skies,
   Martin

