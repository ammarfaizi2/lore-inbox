Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCOTIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCOTIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVCOTFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:05:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:53442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261785AbVCOTCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:02:12 -0500
Date: Tue, 15 Mar 2005 11:01:46 -0800
From: Andrew Morton <akpm@osdl.org>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, helge.hafting@aitel.hist.no,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.6.11-mm3 mouse oddity
Message-Id: <20050315110146.4b0c5431.akpm@osdl.org>
In-Reply-To: <d120d50005031506252c64b5d2@mail.gmail.com>
References: <20050312034222.12a264c4.akpm@osdl.org>
	<4236D428.4080403@aitel.hist.no>
	<d120d50005031506252c64b5d2@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Tue, 15 Mar 2005 13:25:12 +0100, Helge Hafting
> <helge.hafting@aitel.hist.no> wrote:
> > 2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
> > 2.6.11-mm3: mouse appear as /dev/input/mouse1
> > 
> > No big problem, one change to xorg.conf and I got the mouse back.
> > I guess it wasn't supposed to change like that though?
> >
> 
> Vojtech activated scroll handling in keyboard code by default so now
> your keyboard is mapped to the mouse0 and the mouse moved to mouse1.

We cannot ship a kernel with this change, surely?  Our users would come
hunting for us with pitchforks.

> Vojtech, is is possible to detect whether a keyboard has scroll
> wheel(s) by its ID?

What sort of keyboard has a scroll wheel??

