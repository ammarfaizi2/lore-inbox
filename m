Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992593AbWJTIkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992593AbWJTIkt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992594AbWJTIkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 04:40:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992593AbWJTIks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 04:40:48 -0400
Date: Fri, 20 Oct 2006 01:40:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: sysrq-t broke in -mm :  sysrq-x-show-blocked-tasks.patch needs
 fixing
Message-Id: <20061020014040.a4107ab6.akpm@osdl.org>
In-Reply-To: <17720.34352.587510.727157@cse.unsw.edu.au>
References: <17720.34352.587510.727157@cse.unsw.edu.au>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 18:17:52 +1000
Neil Brown <neilb@suse.de> wrote:

> 
> There is a test in the above mentioned patch in -mm that is backwards,
> so
>   echo t > /proc/sysrq-trigger
> stopped working.
> echo p > /proc/sysrq-trigger isn't working on my x86-64 either just at
> the moment, but that must be something else...

yup, thanks.  Should be fixed in mm2, which is but moments away...
