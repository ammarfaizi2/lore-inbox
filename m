Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJNTWD>; Mon, 14 Oct 2002 15:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262114AbSJNTWD>; Mon, 14 Oct 2002 15:22:03 -0400
Received: from horkos.telenet-ops.be ([195.130.132.45]:31439 "EHLO
	horkos.telenet-ops.be") by vger.kernel.org with ESMTP
	id <S262112AbSJNTWC> convert rfc822-to-8bit; Mon, 14 Oct 2002 15:22:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Bart De Schuymer <bart.de.schuymer@pandora.be>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [RFC] bridge-nf -- map IPv4 hooks onto bridge hooks, vs 2.5.42
Date: Mon, 14 Oct 2002 21:29:56 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org, buytenh@gnu.org, rusty@rustcorp.com.au
References: <200210142005.06292.bart.de.schuymer@pandora.be> <200210142058.53355.bart.de.schuymer@pandora.be> <20021014.120200.77420883.davem@redhat.com>
In-Reply-To: <20021014.120200.77420883.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210142129.56824.bart.de.schuymer@pandora.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is my job to show you why a piece of code isn't going
> to go in.  It is not my job to help you dream up a better
> solution.
>
> Because, frankly I don't care about bridge netfiltering.

You were the one who asked for that patch.

> I do care about keeping the code as clean as possible so I don't
> run into road blocks when trying to rework input/output processing
> just because I let some bogon hack into the tree I must continue to
> support.

Ack.

> You do care about bridge netfiltering, so you are going to be the
> one to find the clean solution that doesn't touch net/ipv4/*.c :-)

I care about Linux. I absolutely don't need a bridging firewall for anything. 
I just happen to know something about it.

> That could work too, I think you'll need to specify a seperate
> destructor in that case, and all this stuff ifdef'd on whether
> bridge netfiltering is enabled or not.

This brings me to another question: I've been told it is the general concensus 
that this bridge firewall should be compiled in the kernel if 
CONFIG_NETFILTER=y. Or should it be a user option? It is predicted that using 
a user option will give alot of questions about the bridge firewall not 
working.

> Again, talk to the netfilter folks.  They may even have ideas
> for you that you haven't dreamt of yet.

Will do.

-- 
cheers,
Bart

