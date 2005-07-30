Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262942AbVG3Asf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbVG3Asf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVG3Ase
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:48:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4749 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262942AbVG3AgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:36:23 -0400
To: yhlu <yhlu.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 io_apic.c: Memorize at bootup where the i8259 is
 connected
References: <m164ut2yx0.fsf@ebiederm.dsl.xmission.com>
	<86802c4405072913464705ecec@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 18:36:13 -0600
In-Reply-To: <86802c4405072913464705ecec@mail.gmail.com> (yhlu.kernel@gmail.com's
 message of "Fri, 29 Jul 2005 13:46:16 -0700")
Message-ID: <m1vf2tf7uq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> Is that for Nvidia CK804 stuff?
>
> Actually in LinuxBIOS I swap the irq 0 and 2 entries in mptable to
> solve the problem. and it could work well with current code.

It is for systems with just a acpi MADT table.  Which is
pretty much the !linuxbios case.

Eric
