Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262167AbUKWEcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbUKWEcM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 23:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbUKVQj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:39:59 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:24797 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262163AbUKVQM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:12:28 -0500
To: pavel@ucw.cz
CC: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <20041121181345.GB729@openzaurus.ucw.cz> (message from Pavel
	Machek on Sun, 21 Nov 2004 19:13:45 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu> <20041121181345.GB729@openzaurus.ucw.cz>
Message-Id: <E1CWGnc-0001MB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Nov 2004 17:12:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ugh, this is going to be "interesting". Perhaps it can have little
> overhead, but hacking pagefault handlers is going to be hard.

Well yes.  The third option (mentioned by Jan Hudec) of backing dirty
pages with a disk file is also appealing, but does not seem to me any
simpler.

Miklos


