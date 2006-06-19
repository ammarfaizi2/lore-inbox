Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbWFSJLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWFSJLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWFSJLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:11:07 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:51361 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751091AbWFSJLF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:11:05 -0400
To: jesper.juhl@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <9a8748490606190204n6e2ea0caua0015f4edd2fe7ac@mail.gmail.com>
	(jesper.juhl@gmail.com)
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	 <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
	 <9a8748490606190121u3c76c6bbif707835ec7e5873c@mail.gmail.com>
	 <E1FsFGX-0002Pp-00@dorka.pomaz.szeredi.hu> <9a8748490606190204n6e2ea0caua0015f4edd2fe7ac@mail.gmail.com>
Message-Id: <E1FsFmG-0002VT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 11:10:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about using TEA (Tiny Encryption Algorithm), XTEA or XXTEA then?
> They are quite simple algorithms, easy to implement and resonably fast
> (with TEA being the simplest, but also weakest).
> A hell of a lot better than just a simple XOR or ADD and probably more
> than sufficient for this purpose.
> 
>   http://en.wikipedia.org/wiki/Tiny_Encryption_Algorithm
>   http://www.simonshepherd.supanet.com/tea.htm
>   http://www.ftp.cl.cam.ac.uk/ftp/papers/djw-rmn/djw-rmn-tea.html

Cool.  I'll add this.

It's not even worth using the crypto framework, since setting it up
would be more code than including the algorithm inline.

Thanks,
Miklos
