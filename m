Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268884AbUIMTLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268884AbUIMTLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 15:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268886AbUIMTLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 15:11:54 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:19289 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S268884AbUIMTLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 15:11:15 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
Date: Mon, 13 Sep 2004 20:50:08 +0200
User-Agent: KMail/1.6.1
Cc: user-mode-linux-devel@lists.sourceforge.net,
       David Jeffery <djeffery@britsys.net>, linux-kernel@vger.kernel.org
References: <20040826020626.GA28471@malice.crymeariver.org> <200409121752.07398.blaisorblade_spam@yahoo.it> <20040913031014.GA13184@ccure.user-mode-linux.org>
In-Reply-To: <20040913031014.GA13184@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409132050.08856.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 September 2004 05:10, Jeff Dike wrote:
> On Sun, Sep 12, 2004 at 05:52:44PM +0200, BlaisorBlade wrote:
> > It worked no worse than current version (which is broken). In fact the
> > 2.4 clone had 2 arguments. So it's obvious.
>
> In fact, it worked better.  It worked on a modern Debian filesystem, where
> my old code didn't.
Oh, well, your version gets the fifth arg right, indeed.
> > However, this is non-standard. I've added just a comment for now, since
> > you may have reason to keep the current code, but such behaviour calls
> > for breakage when things change.

> Yeah, I not sure why I did things the way I did.  That's very old code, and
> there may have been some good reason for it which has since disappeared.

> Offhand, it looks like doing things in the standard way will clean up
> copy_thread a bit.
I agree completely.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
