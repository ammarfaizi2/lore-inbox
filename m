Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267098AbTAGXqr>; Tue, 7 Jan 2003 18:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267577AbTAGXqr>; Tue, 7 Jan 2003 18:46:47 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:35600
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267098AbTAGXqq>; Tue, 7 Jan 2003 18:46:46 -0500
Subject: Re: observations on 2.5 config screens
From: Robert Love <rml@tech9.net>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107233012.GP6626@fs.tum.de>
References: <Pine.LNX.4.44.0301011435300.27623-100000@dell>
	 <20030107233012.GP6626@fs.tum.de>
Content-Type: text/plain
Organization: 
Message-Id: <1041982936.694.786.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-3) 
Date: 07 Jan 2003 18:42:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 18:30, Adrian Bunk wrote:

> Robert, could you comment on whether it's really needed to have the 
> preemt option defined architecture-dependant?
> 
> After looking through the arch/*/Kconfig files it seems to me that the
> most problematic things might be architecture-specific parts of other
> architecturs that don't even offer PREEMPT and the depends on CPU_32 in
> arch/arm/Kconfig.

I think it should be there.  Plus, as you say, it is defined
per-architecture.

The real problem in my opinion is that the category is misnamed.  It is
not "processor options" except for the first couple.  The majority of
the options should be under a title of "core" or "architecture" or
"system options" in my opinion.

	Robert Love

