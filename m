Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264723AbUFAHRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264723AbUFAHRY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 03:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264914AbUFAHRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 03:17:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:45774 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264723AbUFAHRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 03:17:22 -0400
Date: Tue, 1 Jun 2004 00:16:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7-rc2] Add const to some scheduling functions
Message-Id: <20040601001632.1cc185ba.akpm@osdl.org>
In-Reply-To: <6525.1086061616@kao2.melbourne.sgi.com>
References: <6525.1086061616@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>
> Several scheduler macros only read from the task struct, mark them
>  const.  It can generate better code.

It makes no change to the gcc-3.4.0-compiled x86 kernel's size.  Under what
circumstances did you see improvements?
