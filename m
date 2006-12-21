Return-Path: <linux-kernel-owner+w=401wt.eu-S1422717AbWLUFLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWLUFLn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWLUFLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:11:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38719 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422717AbWLUFLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:11:43 -0500
Date: Wed, 20 Dec 2006 21:05:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] add i386 idle notifier (take 3)
Message-Id: <20061220210514.42ed08cc.akpm@osdl.org>
In-Reply-To: <20061220140500.GB30752@frankl.hpl.hp.com>
References: <20061220140500.GB30752@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 06:05:00 -0800
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Hello,
> 
> Here is the latest version of the idle notifier for i386.
> This patch is against 2.6.20-rc1 (GIT). In this kernel, the idle
> loop code was modified such that the lowest level idle
> routines do not have loops anymore (e.g., poll_idle). As such,
> we do not need to call enter_idle() in all the interrupt handlers.
> 
> This patch also duplicates the x86-64 bug fix for a race condition
> as posted by Venkatesh Pallipadi from Intel.
> 
> changelog:
> 	- add idle notification mechanism to i386
> 

None of the above text is actually usable as a changelog entry.  We are
left wondering:

- why is this patch needed?

- what does it do?

- how does it do it?

The three questions which all changelogs should answer ;)
