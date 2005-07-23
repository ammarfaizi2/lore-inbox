Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbVGWKrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbVGWKrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 06:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVGWKrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 06:47:07 -0400
Received: from mail1.kontent.de ([81.88.34.36]:55006 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261271AbVGWKrG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 06:47:06 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Lasse =?utf-8?q?K=C3=A4rkk=C3=A4inen_/_Tronic?= 
	<tronic+lzID=lx43caky45@trn.iki.fi>
Subject: Re: Supermount
Date: Sat, 23 Jul 2005 12:47:16 +0200
User-Agent: KMail/1.8
Cc: ioGL64NX <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org
References: <42E00DD3.9060407@trn.iki.fi> <2de37a440507211450501a8378@mail.gmail.com> <42E12105.3090900@trn.iki.fi>
In-Reply-To: <42E12105.3090900@trn.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507231247.17034.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. Juli 2005 18:38 schrieb Lasse Kärkkäinen / Tronic:
> > Supermount is obsolete there are other tools in userspace that do the
> > job perfectly.
> > e.g ivman which uses hal and dbus.
> 
> They cannot mount on demand, thus cannot do the same job. The boot
> partition, for example, is something that should only be mounted when
> required. The same obviously also goes for network filesystems in many
> cases (i.e. avoid having zillion idling connections to the server).

To mount on demand use autofs. Unmounting and dealing with media removal
is the problem.

	Regards
		Oliver
