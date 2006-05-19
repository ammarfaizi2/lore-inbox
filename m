Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWESQYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWESQYY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWESQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:24:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43475 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbWESQYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:24:23 -0400
Date: Fri, 19 May 2006 09:24:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, Balbir Singh <balbir@in.ibm.com>
Subject: Re: [Patch 0/6] statistics infrastructure
Message-Id: <20060519092411.6b859b51.akpm@osdl.org>
In-Reply-To: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Peschke <mp3@de.ibm.com> wrote:
>
> My patch series is a proposal for a generic implementation of statistics.

This uses debugfs for the user interface, but the
per-task-delay-accounting-*.patch series from Balbir creates an extensible
netlink-based system for passing instrumentation results back to userspace.

Can this code be converted to use those netlink interfaces, or is Balbir's
approach unsuitable, or hasn't it even been considered, or what?

