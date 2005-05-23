Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVEWFHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVEWFHt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 01:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVEWFHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 01:07:49 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:5128 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261846AbVEWFHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 01:07:45 -0400
To: linuxram@us.ibm.com
CC: miklos@szeredi.hu, jamie@shareable.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <1116796229.4397.117.camel@localhost> (message from Ram on Sun,
	22 May 2005 14:10:29 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <20050521134615.GB4274@mail.shareable.org>
	 <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <1116796229.4397.117.camel@localhost>
Message-Id: <E1Da59p-00026j-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 07:07:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes. :) because I will have to change my 'rbind across namespace' patch
> because now detached mounts will have dead_mounts namespace instead of
> null namespace.

I was thinking, that it would get rid of all special casing, but I
realize now, that the ns->root != NULL check still has to be done.  Oh
well...

Miklos
