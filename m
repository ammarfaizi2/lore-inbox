Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267971AbTBSDqb>; Tue, 18 Feb 2003 22:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267973AbTBSDqb>; Tue, 18 Feb 2003 22:46:31 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:17676 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S267971AbTBSDqa>; Tue, 18 Feb 2003 22:46:30 -0500
Date: Wed, 19 Feb 2003 14:56:04 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: desrt <desrt@desrt.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.5: crypto core + block devices + ???
In-Reply-To: <1045625825.2879.8.camel@nothing.desrt.ca>
Message-ID: <Pine.LNX.4.44.0302191454160.1595-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2003, desrt wrote:

> Looking at the way the crypto api works (ie: skatterlists) makes it seem
> vaguely compatible with what I've read about the new block device IO
> mechanisms in 2.5.  Is this an accident?  Is there some generic crypto
> support for block devices planned that will obsolete using the loopback
> driver to this end? (like the pages get decrypted upon loading into the
> buffer cache from the physical media or whatever? i'm not really sure
> how all the block device stuff works,...)
> 

Nothing like this is planned that I'm aware of.


> If there are no deeper motives here and the intention is to continue
> supporting encrypted filesystems via the loopback interface, is there
> anyone working on the project?

Yes, a few people have been working on loopback crypto support for 2.5, 
see the cryptoapi-devel archives.


- James
-- 
James Morris
<jmorris@intercode.com.au>


