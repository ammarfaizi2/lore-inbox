Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318881AbSICSvi>; Tue, 3 Sep 2002 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318883AbSICSvi>; Tue, 3 Sep 2002 14:51:38 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:54537 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S318881AbSICSvh>; Tue, 3 Sep 2002 14:51:37 -0400
Message-ID: <3D750548.9D130AB3@zip.com.au>
Date: Tue, 03 Sep 2002 11:54:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lockup on Athlon systems, kernel race condition?
References: <20020830204022.GC736@hygelac> <3D6FE062.A48B6F03@zip.com.au> <20020903183524.GC2343@hygelac>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> 
> ..
> > Possibly the IPI has got lost - seems that this is a popular failure mode
> > for flakey chipsets/motherboards.
> 
> this sounds like the most likely candidate. I'm working on tracking down 
> documentation for further study. Is there an easy way to determine this
> as the cause?

Some systems will drop nasty messages in the logs when APIC checksum
errors are detected.  And such systems will also be prone to lockups
due to failed delivery.  But whether IPIs can be lost without any such
warning signs: don't know, sorry.
