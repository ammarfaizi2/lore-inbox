Return-Path: <linux-kernel-owner+w=401wt.eu-S932070AbXALP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbXALP0e (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbXALP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:26:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60328 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbXALP0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:26:33 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dan Aloni <da-x@monatomic.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: kexec + USB storage in 2.6.19
References: <20070112122444.GA28597@localdomain>
	<m1mz4oe3xm.fsf@ebiederm.dsl.xmission.com>
	<20070112145710.GA29884@localdomain>
Date: Fri, 12 Jan 2007 08:26:03 -0700
In-Reply-To: <20070112145710.GA29884@localdomain> (Dan Aloni's message of
	"Fri, 12 Jan 2007 16:57:10 +0200")
Message-ID: <m1irfce06s.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Aloni <da-x@monatomic.org> writes:

> I'm attaching the full logs.

Thanks.

> [ 8656.272980] ACPI Error (tbxfroot-0512): Could not map memory at 0000040E for length 2 [20060707]

Ok. This looks like the first sign of trouble.
Normally I would suspect a memory map issue but your e820 memory map looks fine,
although a little different between the two kernels.

Is this enough of a hint for you to dig more deeply?

Eric
