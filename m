Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWGLSZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWGLSZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWGLSZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:25:54 -0400
Received: from hera.kernel.org ([140.211.167.34]:35239 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932427AbWGLSZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:25:01 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Date: Wed, 12 Jul 2006 11:24:32 -0700
Organization: OSDL
Message-ID: <20060712112432.0cd5996f@dxpl.pdx.osdl.net>
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com>
	<200607121652.21920.ak@suse.de>
	<m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
	<200607121808.26555.ak@suse.de>
	<m1ac7ebx0v.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1152728672 14194 10.8.0.74 (12 Jul 2006 18:24:32 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 12 Jul 2006 18:24:32 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.3.1 (GTK+ 2.8.19; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the motivation behind killing the sys_sysctl call anyway?
Sure its more ugly esthetically but it works.

Is it because of the desire to virtualize all namespaces?
