Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVFVPRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFVPRC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVFVPRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:17:00 -0400
Received: from [213.170.72.194] ([213.170.72.194]:62148 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261526AbVFVPLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:11:00 -0400
Message-ID: <42B97F82.6040404@yandex.ru>
Date: Wed, 22 Jun 2005 19:10:58 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org>	 <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com>	 <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>	 <20050621181802.11a792cc.akpm@osdl.org> <1119452212.15527.33.camel@server.cs.pocnet.net>
In-Reply-To: <1119452212.15527.33.camel@server.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> The plugins that add additional VFS semantics (that are currently
> disable) should most definitely not be implemented only inside the
> filesystem. I think Hans did this because it would have been a lot more
> work doing this at the proper layer (which means talking to people and a
> lot of politics...).
I would even do s/should most definitely not/must not/

More filesystems in future may want to use these semantics. There are 
cases when one can't use Reiser4 to implement them, but instead, need to 
implement another file system with the same semantics.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
