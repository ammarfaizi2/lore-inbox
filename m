Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752992AbWKFMsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbWKFMsU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 07:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752994AbWKFMsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 07:48:20 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:35780 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752993AbWKFMsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 07:48:19 -0500
Date: Mon, 06 Nov 2006 21:47:34 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ian Kent <raven@themaw.net>
Subject: Re: [BUG] 2.6.19-rc3 autofs crash on my IA64 box
Cc: "bibo,mao" <bibo.mao@intel.com>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0611031610070.7573@raven.themaw.net>
References: <20061102183020.446D.Y-GOTO@jp.fujitsu.com> <Pine.LNX.4.64.0611031610070.7573@raven.themaw.net>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061106214252.3B37.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

> I've checked this and this is not the only problem.
> Also autofs4_ is called with s->s_root NULL in this case.
> 
> The attached patch ensures that the autofs filesystem is initialized to be 
> catatonic until super block setup is complete which avoids the problem 
> above. It also checks s->s_root before use.
> 
> Could someone seeing this problem try this patch out please.

Sorry for late response. I was off.
I tested your patch on my box. It worked well.

Thanks a lot. :-)



-- 
Yasunori Goto 


