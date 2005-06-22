Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262828AbVFVKgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262828AbVFVKgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbVFVKfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:35:13 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:7686 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262830AbVFVKcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 06:32:13 -0400
To: akpm@osdl.org
CC: pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050622031920.456be89d.akpm@osdl.org> (message from Andrew
	Morton on Wed, 22 Jun 2005 03:19:20 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	<20050622004902.796fa977.akpm@osdl.org>
	<E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	<20050622021251.5137179f.akpm@osdl.org>
	<E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu>
	<20050622024423.66d773f3.akpm@osdl.org>
	<E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu> <20050622031920.456be89d.akpm@osdl.org>
Message-Id: <E1Dl2WD-0007MS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 12:31:41 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yup, that's useless.  That makes the whole CLONE_NEWNS idea unworkable,
> yes?

For solving this problem, yes.

> Have we exhausted the alternatives?

I believe yes.  At least to date no workable alternative has been
suggested.

> (If, as you say, v9fs and samba (did you mean smbfs/cifs?) want
> unprivileged mounts, shouldn't the code which you have there be
> moved out of fs/fuse/ and into fs/?)

Probably.  But since the code is so small, and there's no other user
yet, I didn't want to take the initiative.

Thanks,
Miklos
