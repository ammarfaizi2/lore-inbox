Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUKPKpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUKPKpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUKPKpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:45:30 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:23704 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261954AbUKPKmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:42:51 -0500
To: penberg@gmail.com
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <84144f020411160235616c529b@mail.gmail.com> (message from Pekka
	Enberg on Tue, 16 Nov 2004 12:35:57 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <84144f0204111602136a9bbded@mail.gmail.com>
	 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <84144f020411160235616c529b@mail.gmail.com>
Message-Id: <E1CU0nM-0000iT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 11:42:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Yes.  Would a device node be better?  Perhaps.  This way there's no
> > need to allocate a major/minor for a device.
> 
> ...or fix your Kconfig to select procfs. :)

Yep, that's clearly the winning solution :)

> Hmm? The conversion is guaranteed by the standard which makes them
> redundant. And redundancy does hurt maintainability. The have been
> patches to get rid of the existing casts so please don't introduce new
> ones.

OK, I don't really care either way.

Miklos
