Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263343AbTJaPG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTJaPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:06:56 -0500
Received: from pushme.nist.gov ([129.6.16.92]:7354 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id S263343AbTJaPGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:06:55 -0500
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
References: <20031030141519.GA10700@redhat.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Fri, 31 Oct 2003 10:06:31 -0500
In-Reply-To: <20031030141519.GA10700@redhat.com> (Dave Jones's message of
 "Thu, 30 Oct 2003 14:15:19 +0000")
Message-ID: <9cfd6cdla4o.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And APM suspend seems to have broken in -test8.  Does it work for
anyone?

Ian

Dave Jones <davej@redhat.com> writes:

> Power management.
> ~~~~~~~~~~~~~~~~~
> - 2.6 contains a more up to date snapshot of the ACPI driver. Should
>   you experience any problems booting, try booting with the argument
>   "acpi=off" to rule out any ACPI interaction. ACPI has a much more involved
>   role in bringing the system up in 2.6 than it did in 2.4
> - The old "acpismp=force" boot option is now obsolete, and will be ignored
>   due to the old "mini ACPI" parser being removed.
> - software suspend is still in development, and in need of more work.
>   Use with SMP and/or PREEMPT not advised.
> - The ACPI code will do basic sanity checks on the DMI structure in the BIOS
>   to determine the date it was written. BIOSes older than year 2000 are
>   assumed to be broken. In some circumstances, this assumption is wrong.
>   If you see a message saying ACPI is disabled for this reason, try booting
>   with acpi=force. If things work fine, send the output of dmidecode
>   (http://www.nongnu.org/dmidecode/) to acpi-devel@lists.sf.net
>   with an explanation of why your BIOS shouldn't be blacklisted.

