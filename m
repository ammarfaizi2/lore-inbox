Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266732AbUHIQvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266732AbUHIQvS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266739AbUHIQuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:50:24 -0400
Received: from vena.lwn.net ([206.168.112.25]:57492 "HELO lwn.net")
	by vger.kernel.org with SMTP id S266732AbUHIQuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:50:13 -0400
Message-ID: <20040809165012.25562.qmail@lwn.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: FW: Linux kernel file offset pointer races 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 09 Aug 2004 15:45:12 BST."
             <1092062710.14129.22.camel@localhost.localdomain> 
Date: Mon, 09 Aug 2004 10:50:12 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Linus has
> proposed a different solution that makes it harder for new drivers to
> make the same mistakes again

This (along with the bits which have just gone into BK) hints at a
driver API change.  Inquiring minds are *very* curious about such things
at the moment...  will there be a file_operations method prototype
change associated with the file offset fixes?

Thanks,

jon
