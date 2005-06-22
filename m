Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261623AbVFVQZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbVFVQZn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 12:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVFVQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 12:22:34 -0400
Received: from [213.170.72.194] ([213.170.72.194]:24517 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261644AbVFVQUp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 12:20:45 -0400
Message-ID: <42B98FD5.6050201@yandex.ru>
Date: Wed, 22 Jun 2005 20:20:37 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: =?KOI8-R?Q?Markus_T=F6rnqvist?= <mjt@nysv.org>
Cc: Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com> <20050621181802.11a792cc.akpm@osdl.org> <1119452212.15527.33.camel@server.cs.pocnet.net> <42B97F82.6040404@yandex.ru> <20050622155505.GZ11013@nysv.org>
In-Reply-To: <20050622155505.GZ11013@nysv.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Törnqvist wrote:
> So merge it as it is and move the stuff to the VFS as needed or
> deemed necessary. And enable the pseudo interface, or at least
> set it in menuconfig and enable by default, it needs testing too.
Reiser4 has a number of great (IMO) things like file as directory, 
atomic operations, different kinds of stat data, fibretions, etc, etc. 
Some thing is not yet ready - doesn't matter. Some of this is of general 
interest, some is Reiser4-dedicated.

New interfaces are needed to allow users to utilize that all. My point 
is that the things that are of general interest must not be 
Reiser4-only. For example, I should have a possibility to implement 
files-like-dir in _another_ FS using the same interfaces that Reiser4 
uses. That's all I wanted to say.

The other question that it may be difficult to foresee everything and it 
may make sense to move some things upper in future.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

