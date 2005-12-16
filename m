Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVLPPfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVLPPfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVLPPfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:35:00 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:17562 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751238AbVLPPe7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:34:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=ndOSPzB+L5aAQxxWFuLbfS90z7NRnTJAQRG0xjesA1xXtf/QOqT+a7KXSkIzyet/5bxQT4GCbSN6M8Fx3Df4zihZXtbCkeUZG94fz/G0uSRoQm84Y8cJB0EFUuZV55vJ+AuVOqpwF64+d6nQVFOyRezbm2RLXJ5JGIHhm7Rly5s=
Date: Fri, 16 Dec 2005 16:35:03 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051216163503.289d491e.diegocg@gmail.com>
In-Reply-To: <20051216140425.GY23349@stusta.de>
References: <20051215212447.GR23349@stusta.de>
	<20051215140013.7d4ffd5b.akpm@osdl.org>
	<20051216141002.2b54e87d.diegocg@gmail.com>
	<20051216140425.GY23349@stusta.de>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 16 Dec 2005 15:04:25 +0100,
Adrian Bunk <bunk@stusta.de> escribió:

> My count of bug reports for problems with 4k stacks after Neil's patch
> went into -mm is still at 0.
> 
> Either there are no problems left or noone pays attention to them since 
> disabling 4k stacks "fixed" the problem.
> 
> In both cases there's no reason against applying my patch.

I know, but there's too much resistance to the "pure" 4kb patch. The
8 KB patch does the same thing (enables 4kb stacks)  and at the same
time the 8kb groupies can't flamewar you for it, it covers akpm's
concerns, it puts some pressure on the ndiswrapper guys and leaves
time for the broadcom driver developers to finish, merge and push
to the distributions their driver. The 8kb config option can be
removed in the future when we're sure that it's 100% safe (neil
brown's patch isn''t a good sign). It makes every happy IMO ;)
