Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTDHVvR (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTDHVvR (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:51:17 -0400
Received: from trained-monkey.org ([209.217.122.11]:64516 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP id S261891AbTDHVvQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:51:16 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Martin Hicks <mort@bork.org>,
       linux-kernel@vger.kernel.org, wildos@sgi.com
Subject: Re: [patch] printk subsystems
References: <20030407201337.GE28468@bork.org>
	<20030408184109.GA226@elf.ucw.cz> <m3k7e4ycys.fsf@trained-monkey.org>
	<20030408210251.GA30588@atrey.karlin.mff.cuni.cz>
	<3E933AB2.8020306@zytor.com>
	<20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
From: Jes Sorensen <jes@wildopensource.com>
Date: 08 Apr 2003 18:02:51 -0400
In-Reply-To: <20030408215703.GA1538@atrey.karlin.mff.cuni.cz>
Message-ID: <m3brzgy7ec.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@ucw.cz> writes:

Pavel> Well, #define DEBUG in the driver seems like the way to go. I
Pavel> do not like "subsystem ID" idea, because subsystems are not
Pavel> really well defined etc.

Which doesn't solve the problem as this means the end user will have
to recompile his/her kernel to debug things. When Joe Random is
sitting with his favorite distro CD trying to install it on a brand
new motherboard doing funky things in it's ACPI routing or something
like that, it's very useful for SuSE/Red Hat/Mandrake/Debian etc. to
be able to instruct him to set this debug flag and tell them what
happens.

Cheers,
Jes
