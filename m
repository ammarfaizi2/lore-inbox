Return-Path: <linux-kernel-owner+w=401wt.eu-S1422658AbXAESLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422658AbXAESLg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 13:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422657AbXAESLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 13:11:36 -0500
Received: from hera.kernel.org ([140.211.167.34]:49952 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422653AbXAESLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 13:11:35 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: MoRpHeUz <morpheuz@gmail.com>
Subject: Re: Sony Vaio VGN-SZ340 (was Re: sonypc with Sony Vaio VGN-SZ1VP)
Date: Fri, 5 Jan 2007 13:10:40 -0500
User-Agent: KMail/1.9.5
Cc: "Andrew Morton" <akpm@osdl.org>, "Stelian Pop" <stelian@popies.net>,
       "Mattia Dongili" <malattia@linux.it>,
       "Ismail Donmez" <ismail@pardus.org.tr>,
       "Andrea Gelmini" <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, "Cacy Rodney" <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701051211.08458.lenb@kernel.org> <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com>
In-Reply-To: <7ce7bf330701050924h47546970w36ed189ed147ddb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701051310.41131.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 12:24, MoRpHeUz wrote:
> > What workaround are you using?
> 
>  This one: http://bugzilla.kernel.org/show_bug.cgi?id=7465

Ah yes, the duplicate MADT issue is clearly a BIOS bug.
It is possible that we can tweak our Linux workaround for it to be more
Microsoft Windows Bug Compatbile(TM).

> > The frequency scaling issue sounds like a BIOS/Linux incompatibility.

It looks like this issue results from that above,
rather than being an additional problem.

> > The nvidia issue sounds like an interrupt issue, so please reproduce
> > it using the open source nvidia driver (not the nvidia binary),
> > and include the lspci -vv output, dmesg, and /proc/interrupts.
> 
>   Will try that !

If interrupts fail using the open source nvidia driver, (and using the workaround
from the bug above to use the right MADT, please open a new bug report
as I think it would be an independent issue.

thanks,
-Len
