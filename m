Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbUJZV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbUJZV7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUJZV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 17:59:11 -0400
Received: from a.mail.sonic.net ([64.142.16.245]:6319 "EHLO a.mail.sonic.net")
	by vger.kernel.org with ESMTP id S261502AbUJZV6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 17:58:53 -0400
Date: Tue, 26 Oct 2004 14:58:45 -0700
From: David Hinds <dhinds@sonic.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Lincoln D. Durey" <durey@EmperorLinux.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Emperor Research <research@EmperorLinux.com>
Subject: Re: Sony S170 + 1GB ram => Yenta: ISA IRQ mask 0x0000
Message-ID: <20041026215845.GA24541@sonic.net>
References: <200410261342.33924.durey@EmperorLinux.com> <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410261117530.28839@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 11:28:25AM -0700, Linus Torvalds wrote:
> 
> So the question is: 
>  - why have you done any user override at all
>  - and having done so, why aren't the ACPI regions there, marked reserved?
> 
> It looks like the BIOS is doing everything right, and the problem is 
> entirely with the user-defined values..

Maybe "grub" is mucking things up.  Though, the grub manual claims
that it should default to not passing a --mem= option to kernels later
than 2.4.18.

http://www.gnu.org/software/grub/manual/html_node/kernel.html

-- Dave
