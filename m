Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUKPJoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUKPJoF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 04:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKPJmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 04:42:04 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:42722 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261496AbUKPJkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 04:40:47 -0500
To: arjan@infradead.org
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1100596704.2811.17.camel@laptop.fenrus.org> (message from Arjan
	van de Ven on Tue, 16 Nov 2004 10:18:24 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <1100596704.2811.17.camel@laptop.fenrus.org>
Message-Id: <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Nov 2004 10:40:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> somehow I find dropping the lock and then doing a list_del() without
> any kind of verification very suspicious.

list_del() is done with the lock held.  Look closely. 

Miklos
