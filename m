Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTEIDI5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 23:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbTEIDI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 23:08:56 -0400
Received: from fmr02.intel.com ([192.55.52.25]:34809 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S262280AbTEIDIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 23:08:55 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780CCAFE68@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: =?iso-8859-1?Q?=27J=F6rn_Engel=27?= <joern@wohnheim.fh-wedel.de>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'jw schultz'" <jw@pegasys.ws>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Swap Compression
Date: Thu, 8 May 2003 20:21:29 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jörn Engel [mailto:joern@wohnheim.fh-wedel.de]
>
> On Wed, 7 May 2003 20:17:32 -0700, Perez-Gonzalez, Inaky wrote:
> > This reminds me of some howto I saw somewhere of someway to
> > use the MTD drivers to access the unused video RAM and turn
> > it into swap (maybe with blkmtd?) ... probably it can be done
> > with that too.
> 
> Jupp, if you know the physical address range of the RAM, it's a piece
> of cake. Except that the slram option parsing is not user-friendly,
> with me being an examplary user.

It should be ... I need to find some time to dig that howto and
try to do it ...

> For memory above 4GB, things are harder. Basically you'd have to write
> a new mtd driver that copies some of the highmem code. Maybe a day or
> two plus testing.

Ok, right to the stack of 'would be nice to work on' stuff. 

The "feeling" thing is going to be groovy to test - I guess some parallel
kernel compiles would do - hmmm ... will think about it.

Thanks,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
