Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265760AbTIERc1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265762AbTIERc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:32:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:9664 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265760AbTIERc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:32:26 -0400
Date: Fri, 5 Sep 2003 10:14:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, sunil.saxena@intel.com,
       asit.k.mallick@intel.com, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH] idle using PNI monitor/mwait (take 2)
Message-Id: <20030905101424.59fa1fc7.akpm@osdl.org>
In-Reply-To: <7F740D512C7C1046AB53446D3720017304A727@scsmsx402.sc.intel.com>
References: <7F740D512C7C1046AB53446D3720017304A727@scsmsx402.sc.intel.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nakajima, Jun" <jun.nakajima@intel.com> wrote:
>
> Attached is a patch that enables PNI (Prescott New Instructions)
> monitor/mwait in the kernel idle. 

Thanks, looks good.

Why is there a local_irq_enable() on entry to mwait_idle()?

