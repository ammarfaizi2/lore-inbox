Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRDUTOO>; Sat, 21 Apr 2001 15:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132838AbRDUTOF>; Sat, 21 Apr 2001 15:14:05 -0400
Received: from cr502987-a.rchrd1.on.wave.home.com ([24.42.47.5]:12815 "EHLO
	the.jukie.net") by vger.kernel.org with ESMTP id <S132834AbRDUTN5>;
	Sat, 21 Apr 2001 15:13:57 -0400
Date: Sat, 21 Apr 2001 15:13:43 -0400 (EDT)
From: Bart Trojanowski <bart@jukie.net>
X-X-Sender: <bart@localhost>
To: Tamas Nagy <nagytam@rerecognition.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Idea: Encryption plugin architecture for file-systems
In-Reply-To: <NFBBIDPOFIIFCBDDFGLEGEMICCAA.nagytam@rerecognition.com>
Message-ID: <Pine.LNX.4.33.0104211509310.31611-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 21 Apr 2001, Tamas Nagy wrote:

> extend the current file-system with an optional plug-in system, which allows
> for file-system level encryption instead of file-level. This could be used
> transparently for applications or even for file-system drivers.  This
> doesn't mean an encrypted file-system, but a transparent encryption of a
> media instead.

Tamas,
  you may want to read this:

    http://encryptionhowto.sourceforge.net/Encryption-HOWTO-4.html

  the international kernel patch (www.kerneli.org) has had this
implemented for some time.  There is lot more info on crypto in Linux at:

  http://encryptionhowto.sourceforge.net/

> Advantages:
> #1: optional security level for every data, without user interaction.
> #2: if this idea is used e.g. for portable media (like cdrom), your backup
> could be in safe also.
> #3: (almost;)) everybody could create own security plugin for their data,
> and not have to trust on the designers of a secure file systems.

I don't think it's that involved but you can certainly apply a cipher to a
mounted partition.

> So, what do you think about this? Is Linux kernel enough flexible to do
> this? What changes are necessary to do such a thing? Is there any other way,
> to have own security for file-systems or portable medias? Is this
> implementation could be used in the US?

You can use it in the states but you cannot develop for it within the
states - well, the regulations changes but I am not sure if the kerneli
guys will trust that... that's a totally different debate in itself.

Bart.

-- 
	WebSig: http://www.jukie.net/~bart/sig/

