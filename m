Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSKUS6D>; Thu, 21 Nov 2002 13:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266307AbSKUS6D>; Thu, 21 Nov 2002 13:58:03 -0500
Received: from borg.org ([208.218.135.231]:28857 "HELO borg.org")
	by vger.kernel.org with SMTP id <S266112AbSKUS6C>;
	Thu, 21 Nov 2002 13:58:02 -0500
Date: Thu, 21 Nov 2002 14:05:10 -0500
From: Kent Borg <kentborg@borg.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Message-ID: <20021121140510.N16336@borg.org>
References: <20021121125240.K16336@borg.org> <3DDD24E7.4040603@pobox.com> <20021121133922.M16336@borg.org> <1037906458.7660.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1037906458.7660.74.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 21, 2002 at 07:20:58PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 07:20:58PM +0000, Alan Cox wrote:
> Flash file systems are very very likely to leave old data around

Another example of why this needs to be done in the file system.  (And
that help is sometimes needed from the "disk" particularly in cases
like flash IDE rives.)

And even if done well in ext2/3 it would not likely be flawless.
Still, it seems one of those cases where perfect can be the enemy of
good.

Something tells me that when the s-attribute was abandoned there were
not many Linux notebooks being carried around.  What with RAM having
been limited a swap hard on NiCd batteries.

Also, encryption keys can be coerced in many cases where on-going
secure deletion would remain secure.  Linux is picking up other
security features, it might be time to revisit this.


-kb, the Kent who is still curious about the history of the
s-attribute even as the thread threatens to drift off.
