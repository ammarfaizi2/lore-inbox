Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263982AbTEFQbi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263981AbTEFQap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:30:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:7808 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263973AbTEFQaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:30:20 -0400
Date: Tue, 6 May 2003 17:42:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: linux-kernel@vger.kernel.org
Subject: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506164252.GA5125@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was mulling over a commercial project proposal, and this question
came up:

What's the position of kernel developers towards using the GPL'd Linux
kernel modules - that is, device drivers, network stack, filesystems
etc. - with a binary-only, closed source kernel that is written
independently of Linux?

I realise that linking the modules directly with the binary kernel is
a big no no, but what if they are dynamically loaded?

There seems to be a broad agreement, and I realise it isn't unanimous,
that dynamically loading binary-only modules into the Linux kernel is
ok.  Furthermore, there are some funny rules about which interfaces a
binary-only module may use and which it may not, before it's
considered a derivative work of the kernel.

So, as dynamic loading is ok between parts of Linux and binary-only
code, that seems to imply we could build a totally different kind of
binary-only kernel which was able to make use of all the Linux kernel
modules.  We could even modularise parts of the kernel which aren't
modular now, so that we could take advantage of even more parts of Linux.

What do you think?

-- Jamie


