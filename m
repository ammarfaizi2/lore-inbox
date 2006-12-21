Return-Path: <linux-kernel-owner+w=401wt.eu-S1422714AbWLUFJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422714AbWLUFJq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 00:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422717AbWLUFJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 00:09:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38657 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422714AbWLUFJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 00:09:45 -0500
Date: Wed, 20 Dec 2006 21:09:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: David Rientjes <rientjes@cs.washington.edu>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [Patch](memory hotplug) fix compile error for i386 with NUMA
 config (take 3).
Message-Id: <20061220210932.282dcd45.akpm@osdl.org>
In-Reply-To: <20061220225927.F016.Y-GOTO@jp.fujitsu.com>
References: <20061220225927.F016.Y-GOTO@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 23:09:58 +0900
Yasunori Goto <y-goto@jp.fujitsu.com> wrote:

> +EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);

Exported to acpi_memhotplug, I guess.

Is not actually needed on NUMAQ.   I don't think anyone will
complain much ;)
