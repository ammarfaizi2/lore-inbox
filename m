Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbTDGMck (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 08:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTDGMcj (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 08:32:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44691
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263411AbTDGMch (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 08:32:37 -0400
Subject: Re: 2.5.66-bk12 causes "rpm" errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@digeo.com>, "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049680078.753.173.camel@localhost>
References: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
	 <20030406183234.1e8abd7f.akpm@digeo.com>
	 <1049679689.753.170.camel@localhost>  <1049680078.753.173.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049715944.2967.44.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Apr 2003 12:45:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-07 at 02:47, Robert Love wrote:
> On Sun, 2003-04-06 at 21:41, Robert Love wrote:
> 
> > I have not yet tracked down what in 2.5 is broken, but Red Hat's kernel
> > obviously does not have this flaw.
> 
> I should clarify this.
> 
> I do not know if the flaw is in 2.5.  It might be a behavior of Red
> Hat's kernel which rpm(8) assumes.

I've forwarded the report to the RH RPM maintainer to look into. I know
the non NPTL cases are ok because I never run Red Hat kernels except in
the install process. If there are subtle NPTL differences anything is of
course possible

