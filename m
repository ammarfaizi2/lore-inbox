Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUHIPwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUHIPwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHIPwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 11:52:21 -0400
Received: from the-village.bc.nu ([81.2.110.252]:34761 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266701AbUHIPro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 11:47:44 -0400
Subject: Re: FW: Linux kernel file offset pointer races
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Jirka Kosina <jikos@jikos.cz>, Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411736CB.2040607@bio.ifi.lmu.de>
References: <XFMail.20040805104213.pochini@shiny.it>
	 <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
	 <411736CB.2040607@bio.ifi.lmu.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092062710.14129.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 09 Aug 2004 15:45:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-09 at 09:33, Frank Steiner wrote:
> So this is for 2.4. What about 2.6? Distributors like RedHat have patched
> their 2.6.7 kernel accordingly, but I haven't found anything similar in
> the kernel tree from kernel.org. Do you know if there is any a fix for
> the 2.6 tree, too?

If you want a fix now grab the Red Hat or SuSE published fixes. The
final stuff will probably look very different because Linus has
proposed a different solution that makes it harder for new drivers to
make the same mistakes again

