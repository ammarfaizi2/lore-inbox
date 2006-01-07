Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161043AbWAGX10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161043AbWAGX10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWAGX10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 18:27:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161043AbWAGX1Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 18:27:25 -0500
Date: Sat, 7 Jan 2006 15:27:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/2] swsusp: low level interface
Message-Id: <20060107152700.692c52e7.akpm@osdl.org>
In-Reply-To: <200601072156.25876.rjw@sisk.pl>
References: <200601071328.39707.rjw@sisk.pl>
	<20060107052049.43ded9fd.akpm@osdl.org>
	<200601071457.54112.rjw@sisk.pl>
	<200601072156.25876.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> Could you please see if this looks better than the previous one?
>

I think so.  I guess we should wrap the swapfile.c functions in
CONFIG_SOFTWARE_SUSPEND though.
