Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWD0HXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWD0HXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWD0HXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:23:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38803 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751338AbWD0HXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:23:24 -0400
Subject: Re: Simple header cleanups
From: Arjan van de Ven <arjan@infradead.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200604271010.06711.vda@ilport.com.ua>
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	 <1146107871.2885.60.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	 <200604271010.06711.vda@ilport.com.ua>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 09:23:12 +0200
Message-Id: <1146122592.2894.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 10:10 +0300, Denis Vlasenko wrote:
> On Thursday 27 April 2006 06:31, Linus Torvalds wrote:
> > 
> > On Thu, 27 Apr 2006, David Woodhouse wrote:
> > > 
> > > Agreed. And distributions and library maintainers _will_ fix them. Are
> > > we to deny those people the tools which will help them to keep track of
> > > our breakage and submit patches to fix it?
> > 
> > No. As mentioned, as long as the target audience is distributions and 
> > library maintainers, I definitely think we should do help them as much as 
> > possible. Our problems have historically been "random people" who have 
> > /usr/include/linux being the symlink to "kernel source of the day", which 
> > is an unsupportable situation.
> 
> Maybe we should have a script which processes kernel's include/linux/*
> files and produces sanitized set of headers (by deleting
> "#ifdef __KERNEL__" blocks, etc), which will be treated at
> *the* official kernel<->userspace API and will be used by glibc etc?
> 
> Such "kernel header sanitizator" script is to be maintained
> and distributed as part of kernel tree.

this is what David is doing btw ;)


