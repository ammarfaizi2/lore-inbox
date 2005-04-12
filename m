Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVDLWaK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVDLWaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262214AbVDLUi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:38:28 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:11232 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262574AbVDLTLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 15:11:11 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050412171426.GB14633@mail.shareable.org> (message from Jamie
	Lokier on Tue, 12 Apr 2005 18:14:26 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411221324.GA10541@nevyn.them.org> <E1DLEsQ-00015Z-00@dorka.pomaz.szeredi.hu> <20050412143237.GB10995@mail.shareable.org> <E1DLMrh-0001lm-00@dorka.pomaz.szeredi.hu> <20050412161303.GI10995@mail.shareable.org> <E1DLOO0-0001xj-00@dorka.pomaz.szeredi.hu> <20050412164501.GB14149@mail.shareable.org> <E1DLOcX-0001zw-00@dorka.pomaz.szeredi.hu> <20050412171426.GB14633@mail.shareable.org>
Message-Id: <E1DLQmg-0002Dl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 21:10:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Still can't find it :)
> > 
> > Which kernel?  Which file?
> 
> I'm looking at linux-2.4.30/fs/nfs/dir.c.

Ahh, OK.

nfs_permission() in 2.6 looks quite a bit different.  And permission
bits are not used if ->access() is available.

Miklos
