Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbVGIHYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbVGIHYa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVGIHY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:24:29 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:65013 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263161AbVGIHX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:23:57 -0400
Message-ID: <42CF7B83.9000804@namesys.com>
Date: Sat, 09 Jul 2005 00:23:47 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Ed Tomlinson <tomlins@cam.org>, Ed Cogburn <edcogburn@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
References: <200507040211.j642BL6f005488@laptop11.inf.utfsm.cl> <028601c581a0$cb1f3e20$2800000a@pc365dualp2> <dan077$n4t$1@sea.gmane.org> <200507082026.49404.tomlins@cam.org> <Pine.LNX.4.62.0507081737120.4458@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0507081737120.4458@qynat.qvtvafvgr.pbz>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:

>
> remember that Hans is on record (over a year ago) arguing that R3
> should not be fixed becouse R4 was replacing it.

No, I said and say that V3 should not have features added to it, because
features should not be added to a stable branch.  Bug fixes are good.

There are a few V3 bug fixes where the fix is so deep that it belongs in
V4, all of the ones that I can think of at the moment are ones requiring
disk format changes.

Note that in V4, disk format changes are no longer deep fixes because of
plugins.

>
> This type of thing is one of the reasons that you see arguments that
> aren't 'purely code-related' becouse the kernel folks realize that
> _they_ will have to maintain the code over time, Hans and company will
> go on and develop R5 (R10, whatever) and consider R4 obsolete and stop
> maintaining it.

No, we will stop adding features to it at some point, only add bug
fixes, and let it become stable enough for mission critical use.  Of
course, with plugins this becomes more complicated of a policy because
smaller releases with more orthogonal features are easier and more
tempting, and it becomes tempting to version and release plugins rather
than the FS, so I am not sure exactly how this will play out yet.  I
think we will have an option to select experimental plugins individually.

>
> David Lang
>

