Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbTDGOlo (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTDGOlo (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:41:44 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:34055
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262639AbTDGOln 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:41:43 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@digeo.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049715944.2967.44.camel@dhcp22.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
	 <20030406183234.1e8abd7f.akpm@digeo.com>
	 <1049679689.753.170.camel@localhost>  <1049680078.753.173.camel@localhost>
	 <1049715944.2967.44.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1049727199.894.60.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 07 Apr 2003 10:53:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-07 at 07:45, Alan Cox wrote:

> I've forwarded the report to the RH RPM maintainer to look into. I know
> the non NPTL cases are ok because I never run Red Hat kernels except in
> the install process. If there are subtle NPTL differences anything is of
> course possible

Someone reported it was an issue with O_DIRECT, which I guess is also
possible.

Whatever it is, forcing the kernel to 2.2.5 in glibc fixes it.  It is
also fine in the RH kernel.

Thanks for forwarded the issue onward.

	Robert Love

