Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTKJOWZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTKJOWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:22:25 -0500
Received: from nevyn.them.org ([66.93.172.17]:2966 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S263675AbTKJOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:22:24 -0500
Date: Mon, 10 Nov 2003 09:22:22 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031110142222.GA21220@nevyn.them.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <QiyV.1k3.15@gated-at.bofh.it> <3FAF7FC8.8050503@softhome.net> <03111007291500.08768@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03111007291500.08768@tabby>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 07:29:15AM -0600, Jesse Pollard wrote:
> Now back to the copy.. You don't have to use a read/write loop- mmap
> is faster. And this is the other reason for not doing it in Kernel mode.

Actually, last I checked, read/write was actually faster.  Linus
explained why a month or two ago.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
