Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbUDFQOL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUDFQOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:14:11 -0400
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:6793 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263876AbUDFQOH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:14:07 -0400
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Eric Whiting <ewhiting@amis.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <20040406155925.GW2234@dualathlon.random>
References: <40718B2A.967D9467@amis.com>
	 <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com>
	 <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu>
	 <20040406155925.GW2234@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1081268018.4680.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Apr 2004 18:13:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-06 at 17:59, Andrea Arcangeli wrote:

> You should also use a bleeding edge cpu for you measurements with large
> tlb caches, which cpu did you use for your measurements?

afaics all Intel and AMD cpus with more than say 32 or 64 TLB's are
actually 64 bit capable.... so obviously you run a 64 bit kernel there. 
(and amd64 even has that sweet CAM filter on the tlbs to mitigate the
effect even if you run a 32 bit kernel)

