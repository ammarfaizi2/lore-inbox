Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287697AbSAIP64>; Wed, 9 Jan 2002 10:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287684AbSAIP6q>; Wed, 9 Jan 2002 10:58:46 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:64527 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287697AbSAIP6d>; Wed, 9 Jan 2002 10:58:33 -0500
Date: Wed, 9 Jan 2002 18:58:26 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, adilger@turbolabs.com
Subject: Re: [reiserfs-dev] [PATCH] UUID & volume labels support for reiserfs
Message-ID: <20020109185826.A1680@namesys.com>
In-Reply-To: <20020109155504.A4551@namesys.com> <52160000.1010591279@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52160000.1010591279@tiny>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 09, 2002 at 10:47:59AM -0500, Chris Mason wrote:

> >     Attached is the patch that reserves space for volume label and UUID
> > in reiserfs v3.6 superblock.     It also generates random UUID for
> > volumes converted from 3.5 to 3.6 format by the kernel.     Original
> > patch author is Andreas Dilger <adilger@turbolabs.com>.     Please apply.
> This should not be applied until an updated (non beta) reiserfsprogs
> package that supports these features has been released.
Hey, reserving some space in superblock won't hurt.
And when actual reiserfsprogs and util-linux support will appear, people will just start to use these features.
On the other side, if tools supporting this stuff will get out earlier than kernel support, bad things may happen.
And Hans is thinking that time for this patch is right, too.

Bye,
    Oleg
