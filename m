Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965131AbWGKETy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965131AbWGKETy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbWGKETy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:19:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54253 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965131AbWGKETx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:19:53 -0400
Date: Mon, 10 Jul 2006 21:19:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Message-Id: <20060710211951.7bf8320b.akpm@osdl.org>
In-Reply-To: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 16:38:59 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Since sys_sysctl is deprecated start allow it to be compiled out.

This could be a tough one to get rid of (looks at sys_bdflush() again).

I'd suggest we put a sys_bdflush()-style warning in there, see what that
flushes out.

