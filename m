Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131887AbRDGUai>; Sat, 7 Apr 2001 16:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131882AbRDGUa2>; Sat, 7 Apr 2001 16:30:28 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:25101 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131626AbRDGUaQ>; Sat, 7 Apr 2001 16:30:16 -0400
Message-ID: <3ACF790B.72171236@t-online.de>
Date: Sat, 07 Apr 2001 22:31:07 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
 Like I mentioned in a
> previous message, the Via parport code is ugly and should go into a Via
> superio driver.  It is simply not scalable to consider the alternative
> -- add superio code to parport_pc.c for each ISA bridge out there.  I
> think the same principle applies to this discussion as well.  

Yes, superio will go away and replaced by user level utility:
http://home.t-online.de/home/gunther.mayer/lssuperio-0.61.tar.bz2

PNPBIOS and ACPI will help to configure parallel ports (and others),
after some issues have been resolved.

Again this will be builtin to parport (and not parport_acpi.o etc)
to make it failproof.
