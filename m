Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753821AbWKHEfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbWKHEfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbWKHEfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:35:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46728 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753821AbWKHEfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:35:09 -0500
Date: Tue, 7 Nov 2006 20:35:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: ak@suse.de, shaohua.li@intel.com, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, ashok.raj@intel.com
Subject: Re: [patch 2/4] introduce the mechanism of disabling cpu hotplug
 control
Message-Id: <20061107203504.b8e17ea8.akpm@osdl.org>
In-Reply-To: <20061107200133.A5933@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com>
	<20061107173624.A5401@unix-os.sc.intel.com>
	<20061107174024.B5401@unix-os.sc.intel.com>
	<20061107195430.37f8deb0.akpm@osdl.org>
	<20061107200133.A5933@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 20:01:34 -0800
"Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:

> I wanted to add something like disable_cpu_hotplug

My point is, `enable_cpu_hotplug' is nicer

	if (enable_cpu_hotplug)
		...
	if (!enable_cpu_hotplug)
		...

versus

	if (disable_cpu_hotplug)
		...
	if (!disable_cpu_hotplug)
		...			/* My brain hurts */



