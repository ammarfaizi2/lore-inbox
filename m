Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWEWPJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWEWPJl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWEWPJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:09:41 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:51852 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751335AbWEWPJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:09:40 -0400
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
From: Steven Rostedt <rostedt@goodmis.org>
To: Simon Oosthoek <simon.oosthoek@ti-wmc.nl>
Cc: Stephen Hemminger <shemminger@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Herman Elfrink <herman.elfrink@ti-wmc.nl>
In-Reply-To: <44732162.6080107@ti-wmc.nl>
References: <44731733.7000204@ti-wmc.nl>
	 <20060523073851.39c3b5fe@localhost.localdomain>
	 <44732162.6080107@ti-wmc.nl>
Content-Type: text/plain
Date: Tue, 23 May 2006 11:09:32 -0400
Message-Id: <1148396972.21012.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 16:51 +0200, Simon Oosthoek wrote:

> > Use of /proc for an API is no longer desirable. Please rewrite.
> > -
> 
> hmm, ok, I'm not sure this will happen anytime soon (being a rather low 
> priority thing, which is also the reason it's not submitted as patch to 
> the kernel and not signed off), but what is currently the desirable method?
> 

 sysfs is the new interface into the kernel.  /proc is for processes
only (besides the old stuff).

Read up on:
 Documentation/filesystems/sysfs.txt and Documentation/kobject.txt

-- Steve


