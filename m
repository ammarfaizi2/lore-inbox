Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbUJ1SeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbUJ1SeB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262893AbUJ1Sdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:33:51 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:34490 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261847AbUJ1SdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:33:12 -0400
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: akpm@osdl.org, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch 7/7] uml: resolve symbols in back-traces
Date: Thu, 28 Oct 2004 20:34:21 +0200
User-Agent: KMail/1.7.1
Cc: jdike@addtoit.com, cw@f00f.org
References: <200410272223.i9RMNj921852@mail.osdl.org>
In-Reply-To: <200410272223.i9RMNj921852@mail.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282034.21922.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 00:27, akpm@osdl.org wrote:
> From: Chris Wedgwood <cw@f00f.org>

> Resolve symbols in back-traces.

> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
The idea is right - I already had it in my tree, with some little changes (for 
instance including the symbol address and so on). So I'll send it reviewed a 
bit.

I had not yet sent it because there was more critical stuff and because 
sometimes on panic it does not work yet - this seems to be a missing flush 
from the UML console drivers :-(, a bit long to solve because currently the 
locking is broken (a semaphore is used in process context, nothing in 
interrupt context).

And removing the final Emacs comment is not welcome (I don't care, but Jeff 
does. If that should be removed, that's a separate problem).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
