Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVEWFKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVEWFKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 01:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVEWFJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 01:09:30 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:6664 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261846AbVEWFJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 01:09:23 -0400
To: linuxram@us.ibm.com
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, jamie@shareable.org
In-reply-to: <1116795059.4397.111.camel@localhost> (message from Ram on Sun,
	22 May 2005 13:51:00 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
	 <1116670073.4397.77.camel@localhost>
	 <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
	 <1116793554.4397.102.camel@localhost> <1116795059.4397.111.camel@localhost>
Message-Id: <E1Da5BO-00027F-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 23 May 2005 07:08:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch failed rbinds in some cases. Fixed it. The enclosed patch
> has a high chance of being bug free.

Except not setting mnt_namespace corretly, it does seem to be ok.

Miklos
