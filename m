Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbULFSUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbULFSUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbULFSUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:20:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261592AbULFSUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:20:00 -0500
Subject: Re: [RFC] dynamic syscalls revisited
From: Arjan van de Ven <arjan@infradead.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, Adrian Bunk <bunk@stusta.de>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
References: <1101741118.25841.40.camel@localhost.localdomain>
	 <20041129151741.GA5514@infradead.org>
	 <Pine.LNX.4.53.0411291740390.30846@yvahk01.tjqt.qr>
	 <1101748258.25841.53.camel@localhost.localdomain>
	 <20041205234605.GF2953@stusta.de>
	 <1102349255.25841.189.camel@localhost.localdomain>
	 <1102353388.25841.198.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0412061026490.5219@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1102356738.8767.2.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 06 Dec 2004 13:18:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I didn't know we were on a crusade to end all binary modules at all costs. 
> Why not just make _all_ symbols in the kernel EXPORT_SYMBOL_GPL then? I 
> really believe this is taking things to new levels of silliness, we should 
> also possibly consider adding code in glibc to stop proprietary 
> libraries/applications from running. What do you think?


unlike the glibc license (LGPL) the kernel license (GPL) does not allow 
for binary only modules to be linked against it.
So your question is a bit weird... 

