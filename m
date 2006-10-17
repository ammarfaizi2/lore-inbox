Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbWJQP5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbWJQP5o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 11:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWJQP5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 11:57:44 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:61473
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751176AbWJQP5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 11:57:43 -0400
Message-Id: <453519EE.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 17 Oct 2006 16:59:10 +0100
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: config SYSCTL_SYSCALL
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the purpose of

config SYSCTL_SYSCALL
	bool "Sysctl syscall support" if EMBEDDED
	default n

Allowing only embedded to turn this *on* ? Normally, you want
embedded to have more freedom in turning stuff off, so this
looks odd to me (and on one of my older boxes I definitely have
at least one OS-provided tool that uses this syscall, so I'd like
to be able to turn it on.

Thanks for an explanation,
Jan
