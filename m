Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264936AbSLPDzH>; Sun, 15 Dec 2002 22:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSLPDzH>; Sun, 15 Dec 2002 22:55:07 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:53769
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264936AbSLPDzH>; Sun, 15 Dec 2002 22:55:07 -0500
Subject: Re: /proc/cpuinfo and hyperthreading
From: Robert Love <rml@tech9.net>
To: Scott Robert Ladd <scott@coyotegulch.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <FKEAJLBKJCGBDJJIPJLJCEJPDLAA.scott@coyotegulch.com>
References: <FKEAJLBKJCGBDJJIPJLJCEJPDLAA.scott@coyotegulch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1040011359.3458.556.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Dec 2002 23:02:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-15 at 22:58, Scott Robert Ladd wrote:

> Am I correct to infer that the "siblings" entry refers to the 2-way
> hyperthreading on my CPU?

Yep, the 'siblings' value is the number of virtual processors in the
physical package.

Do you only see one processor listing in /proc/cpuinfo, though?  You
should see one for each (virtual) processor.  That means two in a single
HT-enabled P4, each with the same physical id.

So it seems your chip works... is the kernel compiled for SMP?

	Robert Love

