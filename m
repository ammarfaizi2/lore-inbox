Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbTLRESd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 23:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264931AbTLRESd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 23:18:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:22710 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264930AbTLRESb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 23:18:31 -0500
Date: Wed, 17 Dec 2003 20:13:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: zhimin@iss.nus.edu.sg
Cc: linux-kernel@vger.kernel.org
Subject: Re: Looking for kernel boot option documentation
Message-Id: <20031217201350.231a8e55.rddunlap@osdl.org>
In-Reply-To: <opr0cwdq0jvxu3hn@localhost>
References: <opr0cwdq0jvxu3hn@localhost>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003 11:09:16 +0800 Choo Zhi Min <zhimin@iss.nus.edu.sg> wrote:

| Hi,
| 
| Where can I find documentation on kernel boot options?
| 
| I have seen kernel boot options that look very similar to each other that 
| I don't know if it is typo-error or just alternative form.
| 
| E.g.
| 
| apic
| apicon
| apic=on
| noapic
| 
| acpi=off
| acpi=force
| acpismp=force
| pci-noacpi
| pci=noacpi

See this text file in the kernel tarball:

  linux-m.n.p/Documentation/kernel-parameters.txt

where m.n.p is replaced by a version number (major, minor, patchlevel).

--
~Randy
