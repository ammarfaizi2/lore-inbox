Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287841AbSAIQpG>; Wed, 9 Jan 2002 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287828AbSAIQoq>; Wed, 9 Jan 2002 11:44:46 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:11538 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287827AbSAIQog>; Wed, 9 Jan 2002 11:44:36 -0500
Date: Wed, 9 Jan 2002 19:44:30 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for reiserfs
Message-ID: <20020109194430.A2058@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny> <20020109185826.A1680@namesys.com> <100150000.1010592449@tiny> <20020109192526.A1732@namesys.com> <145590000.1010594312@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <145590000.1010594312@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 09, 2002 at 11:38:32AM -0500, Chris Mason wrote:
> >> >> This should not be applied until an updated (non beta) reiserfsprogs
> >> >> package that supports these features has been released.
> >> > Hey, reserving some space in superblock won't hurt.
> >> Reserving it is fine ;-)  Using it isn't a good idea until the progs
> > So we did it (reserved) ;)
> > We do not use it. (generating of UUID does not count)
> Yes, generating a uuid and storing in the super block counts as using the
> field ;-)
Does filling something with zeroes counts as "using the field"? ;)

> The point is that we should never add something to the kernel until our
> utils package understands it.  Yes, this is a simple case, but if we want
In fact, current reiserfsprogs understands these fields (look into the the struct super_block definition in
reiserfsprogs). It just cannot change content of the fields.

> to call reiserfs stable, there are some basic rules we need to start
> following.
Sure.

Bye,
    Oleg
