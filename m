Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263742AbVBCQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263742AbVBCQNm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 11:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbVBCQLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 11:11:34 -0500
Received: from kelly.bath.ac.uk ([138.38.32.20]:56411 "EHLO kelly.bath.ac.uk")
	by vger.kernel.org with ESMTP id S262953AbVBCQHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 11:07:03 -0500
Date: Thu, 3 Feb 2005 16:07:01 +0000 (GMT)
From: S Iremonger <exxsi@bath.ac.uk>
X-X-Sender: exxsi@amos.bath.ac.uk
To: Pankaj Agarwal <pankaj@toughguy.net>
cc: linux-os@analogic.com, linux-kernel@vger.kernel.org,
       Linux Net <linux-net@vger.kernel.org>
Subject: Re: Query - Regarding strange behaviour.
In-Reply-To: <015901c50a07$721f2620$8d00150a@dreammac>
Message-ID: <Pine.GSO.4.53.0502031602400.21155@amos.bath.ac.uk>
References: <001501c509ff$d4be02e0$8d00150a@dreammac>
 <Pine.LNX.4.61.0502031017430.9404@chaos.analogic.com>
 <015901c50a07$721f2620$8d00150a@dreammac>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanner: 2b0cf978998f6064c7a2a3d185895e0994200e0c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>its not even allowing me to copy it ...then surely it wont allow me mv as
>well... what else can i try...
>[root@test root]# mount
>/dev/hda2 on / type ext3 (rw)
>[root@test /]# cd /usr
>[root@test usr]# cp bin testbin
>cp: omitting directory `bin'

"cp" does not normally copy direcrories as such by DEFAULT.

Use the "-R" flag on "cp" to make it 'recurse' and copy the whole
  directory and directory/files under it.

e.g. "cp -R bin bincopy"


And, show us all the results of the following 2 commands, please.

ls -ld /usr/bin
lsattr -d /usr/bin

--S Iremonger <exxsi@bath.ac.uk>

