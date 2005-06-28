Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbVF1JUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbVF1JUL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 05:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVF1JTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 05:19:34 -0400
Received: from [213.170.72.194] ([213.170.72.194]:55516 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261836AbVF1JQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 05:16:55 -0400
Message-ID: <42C1157E.8040506@yandex.ru>
Date: Tue, 28 Jun 2005 13:16:46 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Vladimir Saveliev <vs@namesys.com>, Hans Reiser <reiser@namesys.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: reiser4 merging action list
References: <42BB7B32.4010100@slaphack.com.suse.lists.linux.kernel> <200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl.suse.lists.linux.kernel> <20050627092138.GD11013@nysv.org.suse.lists.linux.kernel> <20050627124255.GB6280@thunk.org.suse.lists.linux.kernel> <42C0578F.7030608@namesys.com.suse.lists.linux.kernel> <20050627212628.GB27805@thunk.org.suse.lists.linux.kernel> <42C084F1.70607@namesys.com.suse.lists.linux.kernel> <p73vf3zuqzq.fsf@verdi.suse.de> <1119947829.3495.25.camel@tribesman.namesys.com> <20050628091117.GJ8035@wotan.suse.de>
In-Reply-To: <20050628091117.GJ8035@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Yes, i was looking at some older tree with reiser4. Sorry, just
> ignore what is already done.
> 
> But still spin_macros.h should be completely removed imho. Such
> custom lock wrappers are strongly discouraged because it 
> makes it hard for others to read your code.
>
I may comfirm that this makes Reiser4 very difficult to investigate.
Ctags doesn't work with that too..

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
