Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751885AbWCNOJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWCNOJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWCNOJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:09:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39307 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751885AbWCNOJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:09:14 -0500
Subject: Re: Development tree, PLEASE?
From: Arjan van de Ven <arjan@infradead.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Dave Jones <davej@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603140900_MC3-1-BA9A-44CC@compuserve.com>
References: <200603140900_MC3-1-BA9A-44CC@compuserve.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 15:09:06 +0100
Message-Id: <1142345347.3027.34.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 08:57 -0500, Chuck Ebbert wrote:
> In-Reply-To: <20060202221023.GJ11831@redhat.com>
> 
> On Thu, 2 Feb 2006 17:10:25 -0500, Dave Jones wrote:
> 
> > -rw-r--r--    1 davej    davej        1686 Dec 15 23:31 linux-2.6-build-userspace-headers-warning.patch
> > 
> > adds a #error to includes if __KERNEL__ isn't being used
> > (We want people to use the headers from our glibc-kernheaders package,
> > not from the kernel soucre).
> 
>  Red Hat's headers are way out of date.
> 
>  Just try compiling this using FC4's latest kernheaders:
> 
>         ptrace(PTRACE_SETOPTIONS, child, NULL, PTRACE_O_TRACEFORK);
> 
>  PTRACE_O_TRACEFORK is undefined.


what is the bugzilla number for this?


