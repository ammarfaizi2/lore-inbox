Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265114AbSLMQl3>; Fri, 13 Dec 2002 11:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265126AbSLMQl3>; Fri, 13 Dec 2002 11:41:29 -0500
Received: from 195-219-31-160.sp-static.linix.net ([195.219.31.160]:6528 "EHLO
	r2d2.office") by vger.kernel.org with ESMTP id <S265114AbSLMQl2>;
	Fri, 13 Dec 2002 11:41:28 -0500
Message-ID: <3DFA0F6D.1010904@walrond.org>
Date: Fri, 13 Dec 2002 16:48:45 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <3DF9F780.1070300@walrond.org> <mailman.1039792562.8768.linux-kernel2news@redhat.com> <200212131616.gBDGGH302861@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

Sorry for being dense, but what do you mean by 'bindings' ? Hard links?

Andrew

> Frankly, all cases when I had seen the nested symlink farms of that
> depth would be better served by use of bindings - these are not subject
> to any limits on nesting and avoid a lot of PITA inherent to symlink
> farms.  To put it another way, nested symlink farms grow from attempts
> to work around the lack of bindings.  It's not that you need to replace
> all symlinks with bindings, of course - the crown of the tree is usually
> OK, it's the trunk that acts as source of pain.


