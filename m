Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVDMQsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVDMQsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 12:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVDMQsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 12:48:33 -0400
Received: from rev.193.226.232.28.euroweb.hu ([193.226.232.28]:38116 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261394AbVDMQs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 12:48:27 -0400
To: jamie@shareable.org
CC: bulb@ucw.cz, 7eggert@gmx.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <20050413161344.GC12825@mail.shareable.org> (message from Jamie
	Lokier on Wed, 13 Apr 2005 17:13:44 +0100)
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
References: <20050412144529.GE10995@mail.shareable.org> <E1DLNAz-0001oI-00@dorka.pomaz.szeredi.hu> <20050412160409.GH10995@mail.shareable.org> <E1DLOI6-0001ws-00@dorka.pomaz.szeredi.hu> <20050412164401.GA14149@mail.shareable.org> <E1DLOfW-00020V-00@dorka.pomaz.szeredi.hu> <20050412171338.GA14633@mail.shareable.org> <E1DLQkL-0002DS-00@dorka.pomaz.szeredi.hu> <20050413125609.GA9571@vagabond> <E1DLjTV-0004oO-00@dorka.pomaz.szeredi.hu> <20050413161344.GC12825@mail.shareable.org>
Message-Id: <E1DLl1x-0004uT-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Apr 2005 18:47:57 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Look up the rather large linux-kernel & linux-fsdevel thread "silent
> semantic changes with reiser4" and it's followup threads, from last
> year.

Wow, it's 700+ messages.  I got through the first 40, and already feel
dizzy :)

> It's already been tried.  You will also find sensible ideas on what
> semantics it should have to do it properly.

OK, I understand the "slash -> directory, no-slash -> regular file"
semantics.

How do you envision implementing this for "mount directory over file"?

A new mount flag indicating that it's only to be followed down if
there's a slash after the mountpoint?

Thanks,
Miklos
