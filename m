Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265328AbUFRWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUFRWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUFRWCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:02:07 -0400
Received: from ee.oulu.fi ([130.231.61.23]:27816 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263609AbUFRV6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:58:37 -0400
Date: Sat, 19 Jun 2004 00:58:32 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040618215832.GA10369@ee.oulu.fi>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <20040618213252.GS20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20040618213252.GS20632@lug-owl.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:32:52PM +0200, Jan-Benedict Glaw wrote:
> > It makes all characters out of the range 32..126 (except for newline)
> > print as a '?'.
> 
> I don't see why that's needed. I'd say let's better fix ACPI to put
> those strings as a hexdump or something like that.
There's actually some other cases where doing the escaping would be a
good idea.

Try grabbing an old a.out binary, renaming it to something like
\n<0>Oops: ,running it and see what happens...

Combined with an old-enough terminal emulator there could actually
be a bit more trouble than a messed-up screen...

-- 
Pekka Pietikainen
