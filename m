Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTEFUmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTEFUmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:42:22 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:39607 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S261871AbTEFUmI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:42:08 -0400
Date: Tue, 6 May 2003 22:43:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506204305.GA5546@elf.ucw.cz>
References: <20030506164252.GA5125@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506164252.GA5125@mail.jlokier.co.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I was mulling over a commercial project proposal, and this question
> came up:
> 
> What's the position of kernel developers towards using the GPL'd Linux
> kernel modules - that is, device drivers, network stack, filesystems
> etc. - with a binary-only, closed source kernel that is written
> independently of Linux?
> 
> I realise that linking the modules directly with the binary kernel is
> a big no no, but what if they are dynamically loaded?
> 
> There seems to be a broad agreement, and I realise it isn't unanimous,
> that dynamically loading binary-only modules into the Linux kernel is
> ok.  Furthermore, there are some funny rules about which interfaces a
> binary-only module may use and which it may not, before it's
> considered a derivative work of the kernel.
> 
> So, as dynamic loading is ok between parts of Linux and binary-only
> code, that seems to imply we could build a totally different kind of
> binary-only kernel which was able to make use of all the Linux kernel
> modules.  We could even modularise parts of the kernel which aren't
> modular now, so that we could take advantage of even more parts of Linux.
> 
> What do you think?

If you can make those drivers in your userspace, its certainly okay...

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
