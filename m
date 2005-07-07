Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVGGLvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVGGLvS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVGGLqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 07:46:51 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:60690 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261297AbVGGLpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 07:45:04 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <20050707043436.0f17a6e7.akpm@osdl.org> (message from Andrew
	Morton on Thu, 7 Jul 2005 04:34:36 -0700)
Subject: Re: 2.6.13-rc2-mm1
References: <20050707040037.04366e4e.akpm@osdl.org>
	<E1DqUWy-0002hC-00@dorka.pomaz.szeredi.hu> <20050707043436.0f17a6e7.akpm@osdl.org>
Message-Id: <E1DqUoA-0002ju-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 07 Jul 2005 13:44:46 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm inclined to just give up on the permissions thing - if someone comes up
> with something better then fine.
> 
> But I do wonder whether v9fs would be a better place to be concentrating
> the development effort.

v9fs is a network filesystem.  And it's a network filesystem that's
not even very UNIX-y.  It's not easy to extend with Linux specfic
bits, specially if you want to keep the compatibility with the
original.  And all that compatibility and standard compliance just
adds extra layers, that are completely unnecessary for a _local_
userspace filesystem interface.

And even if it were to win on the userspace filesystem front in some
day, that day is very far away (if ever), and a little competition
will have a good effect on v9fs's development I believe.

Miklos
