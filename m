Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264689AbRGELk3>; Thu, 5 Jul 2001 07:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264899AbRGELkS>; Thu, 5 Jul 2001 07:40:18 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:7870 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S264689AbRGELkK>; Thu, 5 Jul 2001 07:40:10 -0400
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200107051139.MAA15813@mauve.demon.co.uk>
Subject: Re: loop device corruption in 2.4.6
To: linux-kernel@vger.kernel.org
Date: Thu, 5 Jul 2001 12:39:36 +0100 (BST)
In-Reply-To: <3B443F11.307A5F61@pp.inet.fi> from "Jari Ruusu" at Jul 05, 2001 01:18:57 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Mark Swanson wrote:
> > I get repeatable errors with 2.4.6 patched with the international encryption
> > patch patch-int-2.4.3.1.bz2 when building loop device filesystems on top of
> > Reiserfs.
> 
<snip>
> And the block size thing is not the only thing wrong with international
> crypto patch. The whole cryptoapi thing is just bloat that does not belong
> in kernel. Cipher name string to number code mappings should be done in user
> space instead of kernel. And the ice on the cake is that cryptoapi ciphers

Why is this any more evil than protocol names in kernel, or filesystem names
in kernel. The consequences of getting the cipher wrong are often worse
than that of getting the filesystem wrong.
<snip>
> Loop-AES is a superior replacement for international crypto patch, for more
> information about loop-AES, see this announcement:

That has a fraction of the features.

And no, I'm not completely happy with crypto-API, I managed to get it to
corrupt a test FS with a few weeks stress-test a while back.

