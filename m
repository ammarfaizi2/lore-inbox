Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUJQUZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUJQUZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUJQUZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:25:51 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:63091 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269286AbUJQUZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:25:43 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=umH+9dDoflr3FL/Xdvh3sbu35RQjbUQy6m8WeUE/4JQ/5dnS0y+CLQ309KfSxF5bWteFGfQipnlgPhLghHkxo2we7VDMuTGqa3PeHc5PsxaHLwcuVbFIXVVgn3wmHKwsB1Mn8DRAEo8s/FLVEEaCRwyFUSqeVARVWQZeg0x/Kd4
Message-ID: <5d6b657504101713253b522889@mail.gmail.com>
Date: Sun, 17 Oct 2004 22:25:43 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: Martijn Sipkema <martijn@entmoot.nl>,
       David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041017201118.GQ7468@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <20041017133537.GL7468@marowsky-bree.de>
	 <5d6b657504101707175aab0fcb@mail.gmail.com>
	 <20041017150509.GC10280@mark.mielke.cc>
	 <5d6b65750410170840c80c314@mail.gmail.com>
	 <000801c4b46f$b62034b0$161b14ac@boromir>
	 <5d6b65750410171033d9d83ab@mail.gmail.com>
	 <002b01c4b483$b2bef130$161b14ac@boromir>
	 <5d6b657504101712336468303c@mail.gmail.com>
	 <20041017201118.GQ7468@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 22:11:18 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2004-10-17T21:33:27, Buddy Lucas <buddy.lucas@gmail.com> wrote:
> 
> > You concluded from this that, if select() says a descriptor is
> > readable, the subsequent recvmsg() must not block. The point is, from
> > your quote I cannot deduct anything but: a recvmsg() on a descriptor
> > that is readable must not block -- which makes perfect sense.
> >
> > But unless POSIX also says something about the conservability of
> > "readability" of descriptors, specifically in between select() and
> > recvmsg(), your conclusion is just wrong.
> 
> What kind of idiotic (and most of all, wrong) hairsplitting are you
> doing here, for heaven's sake? That's obviously exactly what the
> standard implies.

Take this discussion off-list please.
