Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVEKUkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVEKUkq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEKUkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:40:46 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:12808 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261157AbVEKUkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:40:41 -0400
To: 7eggert@gmx.de
CC: serue@us.ibm.com, jamie@shareable.org, 7eggert@gmx.de, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
In-reply-to: <Pine.LNX.4.58.0505112137100.11888@be1.lrz> (message from Bodo
	Eggert on Wed, 11 May 2005 21:46:14 +0200 (CEST))
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
 <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu>
 <20050511190545.GB14646@serge.austin.ibm.com> <Pine.LNX.4.58.0505112137100.11888@be1.lrz>
Message-Id: <E1DVy01-0002LS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 11 May 2005 22:40:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> e.g.
> 
> create_persistent_namespace(char* name)
> destroy_persistent_namespace(char* name)
> list_persistent_namespaces(char * prefix, uint flags)
> # flags & 1: 1=list all namespaces minus prefix
> #            0=trim names at the first slash after stripping prefix

Just create a namespacefs :)

Mkdir creates a new namespace, rmdir removes a namespace, chroot
switches to the namespace.  No new interfaces needed.

Miklos
