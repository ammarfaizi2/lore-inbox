Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262763AbUJ0WzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUJ0WzC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUJ0Wq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:46:59 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24992 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262763AbUJ0Wn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:43:29 -0400
Subject: Re: My thoughts on the "new development model"
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200410271553_MC3-1-8D4F-38E7@compuserve.com>
References: <200410271553_MC3-1-8D4F-38E7@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098913229.7783.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 22:40:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 20:50, Chuck Ebbert wrote:
> On Wed, 27 Oct 2004 at 16:27 +0100 Alan Cox wrote:
> > You missed the remote DoS attack 8(
>   Where?

Posted to netdev along with fixes. See 2.6.9-ac1 or later

> >>   - i8042 fails to initialize with some boards using legacy USB
> >
> > This is really a BIOS issue and its not a new 2.6.9 bug its a long
> > standing and messy story.
> 
>   And the patch in -ac fixes it but there is a cleaner one around
> that does it more properly, right?

The -ac fix handles one corner case. The right fix appears to be to
always disable USB legacy. But for a small fix its mighty risky.

