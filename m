Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbTEBUjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 16:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbTEBUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 16:39:24 -0400
Received: from ns.suse.de ([213.95.15.193]:55825 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263161AbTEBUjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 16:39:19 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021325130.6565-100000@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk.suse.lists.linux.kernel>
	<b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 02 May 2003 22:51:43 +0200
In-Reply-To: <b8udjm$cgq$1@cesium.transmeta.com.suse.lists.linux.kernel>
Message-ID: <p73n0i5138g.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <200305021829.h42ITclA000178@81-2-122-30.bradfords.org.uk>
> By author:    John Bradford <john@grabjohn.com>
> In newsgroup: linux.dev.kernel
> > 
> > Slightly off-topic, but does anybody know whether IA64 or x86-64 allow
> > you to make the stack non-executable in the same way you can on SPARC?
> > 
> 
> x86-64 definitely does, and it's the default on Linux/x86-64.

No we had to turn it off and now it's too late to turn it back on again.
There is also one bug left that prevents it.

-Andi
