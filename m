Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266659AbUBLWml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266666AbUBLWml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 17:42:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:18410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266659AbUBLWmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 17:42:40 -0500
Date: Thu, 12 Feb 2004 14:44:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: shaggy@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] JFS: sane file name handling (0 of 2)
Message-Id: <20040212144428.05b16695.akpm@osdl.org>
In-Reply-To: <200402122056.i1CKut1t006255@kleikamp.dyn.webahead.ibm.com>
References: <200402122056.i1CKut1t006255@kleikamp.dyn.webahead.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shaggy@austin.ibm.com wrote:
>
> Please apply the following patches to -mm.  The first is just a cleanup, but
> the second one changes the default translation of filenames into unicode.
> 
> There have been several complaints about the way that JFS tries to interpret
> the character set of the file names rather than just treating them as strings
> of bytes.  This patch makes the default behavior the "string of bytes"
> treatment, while still allowing the charset-specific behavior with the
> iocharset mount option.
> 
> I don't believe it will cause anyone too much trouble, but it should probably
> spend a little time in -mm before hitting the mainline.

Sure.  Please send them on to Linus as a bk pull when you're happy with them.

> #   Due to its roots in OS/2, JFS has always tried to convert pathnames
> #   into unicode. 

No.....  It came from UnixWare.  I know - I read it on the internet.
