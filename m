Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264875AbSKVOGx>; Fri, 22 Nov 2002 09:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbSKVOGx>; Fri, 22 Nov 2002 09:06:53 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:48025 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S264875AbSKVOGw> convert rfc822-to-8bit; Fri, 22 Nov 2002 09:06:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Date: Fri, 22 Nov 2002 08:13:12 -0600
User-Agent: KMail/1.4.1
Cc: kentborg@borg.org, alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
In-Reply-To: <200211220122.gAM1MQY305783@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211220813.12136.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 November 2002 07:22 pm, Albert D. Cahalan wrote:
> Alan Cox writes:
> > On Thu, 2002-11-21 at 19:05, Kent Borg wrote:
> >> Another example of why this needs to be done in the file system.  (And
> >> that help is sometimes needed from the "disk" particularly in cases
> >> like flash IDE rives.)
> >
> > The file system can't do it
> > The flash device won't give you the info to do it
> > The ide disk wont give you the info to do it
>
> That's being an idealist. You can protect against everybody
> except the NSA and the disk manufacturer. Most likely they'd
> need to spend lots of money in a clean room to get your data.

incomplete list....
	NSA
	DoD
	Homeland Defense gestapo
	disk manufacturer
	anybody willing to spend about $1000-$5000.

And I'm not sure it is impossible to just reset the bad block list either.
I've been able to do that to SCSI drives in the past, so I think it is
still possible to do.
	
> Forget the shred program. It's less useful than having the
> filesystem simply zero the blocks, because it's slow and you
> can't be sure to hit the OS-visible blocks. Aside from encryption,
> the useful options are:
>
> 1. plain old rm  (protect from users)
> 2. filesystem clears the blocks  (protect from root/kernel)
> 3. physically destroy the disk  (protect from NSA & manufacturer)

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
