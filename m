Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272031AbTGRVYC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272017AbTGRVUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:20:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:3226 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271844AbTGRVUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:20:22 -0400
Date: Fri, 18 Jul 2003 14:27:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0-test1 Ext3 Ooops. Reboot needed.
Message-Id: <20030718142720.40983f6a.akpm@osdl.org>
In-Reply-To: <200307182313.23288.gallir@uib.es>
References: <200307181228.40142.gallir@uib.es>
	<20030718140019.4f6667bd.akpm@osdl.org>
	<200307182313.23288.gallir@uib.es>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> wrote:
>
> "File alteration monitor", from Debian.

OK.

> $ apt-cache show fam

I was attacked by dselect as a small child and have since avoided debian. 
Is there a tarball anywhere?

> Nevertheless I saw the same message the morning after updatedb run.

But was the "Process:" also famd in that case?

A bug in the dnotify code is unsurprising - it doesn't get used or tested
much, and many things around it have changed.

