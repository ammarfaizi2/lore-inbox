Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbUCORJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUCORJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:09:27 -0500
Received: from relay2.ptmail.sapo.pt ([212.55.154.22]:64743 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S262705AbUCORJZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:09:25 -0500
From: Claudio Martins <ctpm@rnl.ist.utl.pt>
To: linux-kernel@vger.kernel.org
Subject: Re: unionfs
Date: Mon, 15 Mar 2004 17:09:11 +0000
User-Agent: KMail/1.6.1
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Ian Kent <raven@themaw.net>, Carsten Otte <cotte@freenet.de>,
       mszeredi@inf.bme.hu, herbert@13thfloor.at
References: <200403151235.25877.cotte@freenet.de> <Pine.LNX.4.58.0403152233490.19386@raven.themaw.net> <20040315161323.GD16615@wohnheim.fh-wedel.de>
In-Reply-To: <20040315161323.GD16615@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403151709.11373.ctpm@rnl.ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 15 March 2004 16:13, Jörn Engel wrote:
> On Mon, 15 March 2004 22:35:20 +0800, Ian Kent wrote:
> > I don't understand the requirement properly. Sorry.
>
> Depends on who you ask, but imo it boils down to this:
> - Use one filesystem as backing store, usually ro.
> - Have another filesystem on top for extra functionality, usually rw
>   access.
>
> Famous example is a rw-CDROM, where writes go to hard drive and
> unchanged data is read from CDROM.  But it makes sense for other
> things as well.


  If I understand correctly this unionfs feature would also be the cleanest 
way of changing the root filesystem after using an initrd ramdisk on boot. 
Currently the pivot_root call is used to change root but that still implies a 
bit of a hack. You can read about it on this fine paper:

http://www.cis.udel.edu/~zhi/www.docshow.net/linux/ols.zip


  It's also a good read if you want to understand the linux bootloaders and 
the boot process in general.

Regards

Claudio 

