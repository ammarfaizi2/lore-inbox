Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbTDYS2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263618AbTDYS2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:28:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:23304
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263617AbTDYS2o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:28:44 -0400
Subject: Re: 2.5.68-mm2
From: Robert Love <rml@tech9.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Bill Davidsen <davidsen@tmr.com>, bcrl@redhat.com, akpm@digeo.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20030425112042.37493d02.rddunlap@osdl.org>
References: <20030424163334.A12180@redhat.com>
	 <Pine.LNX.3.96.1030425135538.16623C-100000@gatekeeper.tmr.com>
	 <20030425112042.37493d02.rddunlap@osdl.org>
Content-Type: text/plain
Message-Id: <1051295252.9767.143.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 25 Apr 2003 14:27:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-25 at 14:20, Randy.Dunlap wrote:
>  
> | The point is that even if bash is fixed it's desirable to address the
> | issue in the kernel, other applications may well misbehave as well.
> 
> So when would this ever end?

Exactly what I was thinking.

The kernel cannot be expected to cater to applications or make
concessions (read: hacks) for certain behavior.  If we offer a cleaner,
improved interface which offers the performance improvement, we are
done.  Applications need to start using it.

Of course, I am not arguing against optimizing the old interfaces or
anything of that nature.  I just believe we should not introduce hacks
for application behavior.  It is their job to do the right thing.

	Robert Love

