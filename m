Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbVBYWjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbVBYWjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 17:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVBYWjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 17:39:19 -0500
Received: from peabody.ximian.com ([130.57.169.10]:55745 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262785AbVBYWjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 17:39:17 -0500
Subject: Re: init process and task_struct
From: Robert Love <rml@novell.com>
To: "Josef E. Galea" <josefeg@euroweb.net.mt>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <421FA5FE.5040703@euroweb.net.mt>
References: <421FA5FE.5040703@euroweb.net.mt>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 17:33:22 -0500
Message-Id: <1109370802.24283.17.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 23:26 +0100, Josef E. Galea wrote:

> Does the init process have a task_struct associated with it, and if yes 
> where is this structure created?

Of course.

Stored directly in init_task, declared in <linux/sched.h>, defined in
arch-specific code (arch/i386/kernel/init_task.c on x86).

	Robert Love


