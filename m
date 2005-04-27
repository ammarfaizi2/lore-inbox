Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVD0O1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVD0O1y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 10:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVD0OYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 10:24:17 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:37028 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261632AbVD0OWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 10:22:48 -0400
To: dedekind@infradead.org
CC: linux-kernel@vger.kernel.org, dwmw2@infradead.org, viro@math.psu.edu,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	(dedekind@infradead.org)
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without clear_inode()
	call between
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
Message-Id: <E1DQnQq-00025E-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 16:22:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The following patch fixes the problem. It was tested with JFFS2 (only)
> and works perfectly.

You should send it to Andrew Morton, so it gets some more testing.
FWIW it looks good to me too.

Miklos
