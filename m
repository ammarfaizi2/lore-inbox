Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbVHVWSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbVHVWSM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbVHVWSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:18:11 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:48263 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751310AbVHVWSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:18:10 -0400
Date: Mon, 22 Aug 2005 12:45:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jffs-dev@axis.com
Subject: Re: use of uninitialized pointer in jffs_create()
Message-ID: <20050822104559.GA11876@wohnheim.fh-wedel.de>
References: <9a87484905082015284c1686ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a87484905082015284c1686ec@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 August 2005 00:28:08 +0200, Jesper Juhl wrote:
> 
> gcc kindly pointed me at jffs_create() with this warning : 
> 
> fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> in this function

Real fix would be to finally remove that code.  Except for the usual
"change this function in the whole kernel" stuff, noone has touched it
for ages.

Jörn

-- 
Man darf nicht das, was uns unwahrscheinlich und unnatürlich erscheint,
mit dem verwechseln, was absolut unmöglich ist.
-- Carl Friedrich Gauß
