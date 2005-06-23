Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263068AbVFWTxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263068AbVFWTxB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 15:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262752AbVFWTqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 15:46:49 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:1201 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262858AbVFWTpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 15:45:09 -0400
Message-ID: <42BB1146.5050105@namesys.com>
Date: Thu, 23 Jun 2005 12:45:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.de>
CC: Andrew Morton <akpm@osdl.org>, penberg@gmail.com, ak@suse.de,
       flx@namesys.com, zam@namesys.com, vs@thebsh.namesys.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       penberg@cs.helsinki.fi
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>	<p73d5qgc67h.fsf@verdi.suse.de>	<42B86027.3090001@namesys.com>	<20050621195642.GD14251@wotan.suse.de>	<42B8C0FF.2010800@namesys.com>	<84144f0205062223226d560e41@mail.gmail.com>	<42BB0151.3030904@suse.de> <20050623114318.5ae13514.akpm@osdl.org> <42BB0D99.7070703@suse.de>
In-Reply-To: <42BB0D99.7070703@suse.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

>All the assertions (a quick grep through the code shows something like
>3800 of them) ultimately result in a reiser4_panic, which BUG()'s. Are
>*all* of these assertions really worth taking the system down? I think a
>reiser4_error function that can abort just that filesystem and recover
>somewhat gracefully would be a bit more in order.
>  
>
A good point.  Thanks for it.
