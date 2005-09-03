Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbVICAYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbVICAYp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbVICAYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:24:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51672 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161080AbVICAYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:24:44 -0400
Date: Fri, 2 Sep 2005 17:24:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: Re: [x86_64] Exception when using powernowd.
Message-Id: <20050902172437.7e8ceabd.akpm@osdl.org>
In-Reply-To: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
References: <20050903.021820.1300541056.whatisthis@jcom.home.ne.jp>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyuma Ohta <whatisthis@jcom.home.ne.jp> wrote:
>
> I'm using MSI K8T Neo2 (VIA K8T800 chipset) and Athlon64 3000+
> with  linux x86_64 2.6.13 kernel and Debian/sid.
> When enable powernow-k8 (i.e. using powernowd,cpudyn) to
> saving power, some process is down by null protection and
> system is unstable.
> Then disabling powernow-k8,and reboot, system is very stable.
> 
> I attach any log,please give me a advice.

Did earlier kernels work OK?  Can you identify the most recent 2.6 kernel
which didn't have this bug?
