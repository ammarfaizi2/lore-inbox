Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBIMON>; Sun, 9 Feb 2003 07:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267291AbTBIMNj>; Sun, 9 Feb 2003 07:13:39 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52091 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267280AbTBIMM0>; Sun, 9 Feb 2003 07:12:26 -0500
Date: Sun, 9 Feb 2003 12:22:00 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Roland McGrath <roland@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@digeo.com>,
       Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: heavy handed exit() in latest BK
Message-ID: <20030209122200.B26513@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0302091305180.5085-100000@localhost.localdomain> <Pine.LNX.4.44.0302091322460.5637-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0302091322460.5637-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Feb 09, 2003 at 01:23:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 01:23:14PM +0100, Ingo Molnar wrote:
> 
> Arjan pointed out that this one is needed as well:

but in second thought... modules don't really need to set the
pids at all, since reparent_to_init() is designed for doing so...
