Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbVDLQIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbVDLQIk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 12:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVDLQEw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 12:04:52 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:14559 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262411AbVDLQES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 12:04:18 -0400
To: jamie@shareable.org
CC: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <E1DLN54-0001nO-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 12 Apr 2005 17:13:34 +0200)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu> <20050411214123.GF32535@mail.shareable.org> <E1DLEby-00013d-00@dorka.pomaz.szeredi.hu> <20050412143347.GC10995@mail.shareable.org> <E1DLN54-0001nO-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1DLNrl-0001tm-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 Apr 2005 18:03:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For 1) your porposal makes sense, however for 2) it's useless, since
> now the user doesn't want the hiding.

I realize that the idea _could_ be used to drop 'allow_root' mount
option from the kernel.  Since 'allow_root' doesn't add any security
over 'allow_other' it's safe to do it in userspace.

Goodie :)

Thanks,
Miklos



