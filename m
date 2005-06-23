Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVFWNPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVFWNPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 09:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVFWNNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 09:13:23 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:45049 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262025AbVFWNKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 09:10:52 -0400
Message-ID: <42BAB4DB.9030900@namesys.com>
Date: Thu, 23 Jun 2005 06:10:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.helsinki.fi>, vs <vs@thebsh.namesys.com>
CC: Pekka Enberg <penberg@gmail.com>, Andi Kleen <ak@suse.de>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org.suse.lists.linux.kernel>            <p73d5qgc67h.fsf@verdi.suse.de>            <42B86027.3090001@namesys.com>            <20050621195642.GD14251@wotan.suse.de>            <42B8C0FF.2010800@namesys.com>            <84144f0205062223226d560e41@mail.gmail.com>            <42BA67C9.7060604@namesys.com> <courier.42BA6E17.00005001@courier.cs.helsinki.fi>
In-Reply-To: <courier.42BA6E17.00005001@courier.cs.helsinki.fi>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:

> Hi Hans,
> On Thu, 2005-06-23 at 00:42 -0700, Hans Reiser wrote:
>
>> > These assertion codes are meaningless to the rest of us so please drop
>> > them.
>> I think you don't appreciate the role of assertions in making code
>> easier to audit and debug.
>
>
> I did not say you should drop the assertions. I referred to the
> "nikita-955" part which is redundant and pointless. Using
> __FILE__:__LINE__ (or BUG_ON even) will give you enough information to
> identify where the error occured.

but then it does not tell me who I assign the bug to.

>
> Because Reiser4 hitting an error condition and restarting the machine
> silently is silly. Just do panic() there.

Well, it seems we agreed and did not realize it.  Oh well.  The silent
restart seems like a silly option to have available.  If someone can
think of a case where it is useful, let me know, otherwise vs please
remove it.

