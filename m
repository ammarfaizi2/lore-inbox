Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVFZRHO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVFZRHO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 13:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVFZRHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 13:07:14 -0400
Received: from [213.170.72.194] ([213.170.72.194]:60884 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261462AbVFZRHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 13:07:08 -0400
Message-ID: <42BEE0B4.3030804@oktetlabs.ru>
Date: Sun, 26 Jun 2005 21:07:00 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Hans Reiser <reiser@namesys.com>, Alexander Zarochentsev <zam@namesys.com>,
       Jeff Garzik <jgarzik@pobox.com>, reiserfs-list@namesys.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B8B9EE.7020002@namesys.com> <42B8BB5E.8090008@pobox.com> <200506221824.32995.zam@namesys.com> <20050622142947.GA26993@infradead.org> <42BA2ED5.6040309@namesys.com> <20050626164606.GA18942@infradead.org>
In-Reply-To: <20050626164606.GA18942@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> I'm a bit confused about what you're saying here.  What does the 'vector'
> in all these expressions mean?
> 
> In OO terminology our *_operation structures are interfaces.  Each particular
> instance of such a struct that is filled with function pointers is a class.
> Each instance of an inode/file/dentry/superblock/... that uses these operation
> vectors is an object.
> 
> What I propose (or rather demand ;-)) is that you don't duplicate this
> infrastructure, and add another dispath layer below these objects but instead
> re-use it for what it is done and only handle things specific to reiser4
> in your own code. 

Just out of curiosity, could you please specify few exact examples with 
specific file/function names which duplicate the existing 
infrastructure. What do they duplicate and why? How should these 
functions be implemented on VFS? Ho should the the other FSes 
implement/ignore them? Why are you shure they will fit VFS well? etc.

Thanks.

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
