Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbTIBMly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbTIBMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:41:30 -0400
Received: from pf178.bochnia.sdi.tpnet.pl ([217.97.94.178]:63937 "EHLO
	pf178.bochnia.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id S261415AbTIBMjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:39:36 -0400
Date: Tue, 2 Sep 2003 13:04:58 +0200
From: Maciej Freudenheim <fahren@student.uci.agh.edu.pl>
To: Dale E Martin <dmartin@cliftonlabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4
Message-ID: <20030902110458.GC3490@piggie>
References: <20030901153305.GA1429@cliftonlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <20030901153305.GA1429@cliftonlabs.com>
X-PGP-Key-URL: http://student.uci.agh.edu.pl/~fahren/fahren.gpg
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dale E Martin wrote:

> However, 2.6.0-test4 locks up hard just after loading the PS/2 mouse stuff.
> Unfortunately none the boot messages make it to disk since I don't get far
> enough in the boot process for syslog to turn on.

> CONFIG_ACPI=y

I had exactly the same problems. However, adding pci=noacpi to kernel
boot command line fixes the problem.

Maciej Freudenheim.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Dale E Martin wrote:

> However, 2.6.0-test4 locks up hard just after loading the PS/2 mouse stuff.
> Unfortunately none the boot messages make it to disk since I don't get far
> enough in the boot process for syslog to turn on.

> CONFIG_ACPI=y

I had exactly the same problems. However, adding pci=noacpi to kernel
boot command line fixes the problem.

Maciej Freudenheim.
