Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269257AbUJQSVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269257AbUJQSVI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 14:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJQSVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 14:21:08 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:32012 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269257AbUJQSVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 14:21:01 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ucl7RFUs4O9g0n7ijmz6FCXtXLVMMHsfR2aVZiXNrdOCb0g2s5S7t4PnBqMUfg4RvNyqF1GKtNWobQqd8/UvCmxKGgUYExr/CjaNqODVpD64G0yx9Tp+SYh9Qfw3aW8b4LBKvtBDRQgpXHBNFqjaCM2u7+PM1dVKq4YMA2PVojs
Message-ID: <5d6b657504101711217ec4bc6d@mail.gmail.com>
Date: Sun, 17 Oct 2004 20:21:00 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: Jesper Juhl <juhl-lkml@dif.dk>, David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041017180629.GO7468@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
	 <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost>
	 <5d6b65750410171104320bc6a8@mail.gmail.com>
	 <20041017180629.GO7468@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 20:06:29 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2004-10-17T20:04:21, Buddy Lucas <buddy.lucas@gmail.com> wrote:
> 
> > [ snip ]
> >
> > Also note the examples that Stevens gives. For instance, he explicitly
> > checks for EWOULDBLOCK after a read on a nonblocking fd that has been
> > reported readable by select().
> 
> The specs don't disagree with that. On a O_NONBLOCK socket, that is
> allowed.

I think the specs got to you, man!


Cheers,
Buddy
