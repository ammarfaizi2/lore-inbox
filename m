Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUK2W4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUK2W4O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbUK2Wyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:54:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:35039 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261856AbUK2WtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:49:11 -0500
Message-ID: <41ABA6DC.4090607@osdl.org>
Date: Mon, 29 Nov 2004 14:46:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Roland Dreier <roland@topspin.com>, Gerrit Huizenga <gh@us.ibm.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 3/10 CKRM:  Core ckrm, rcfs
References: <E1CYqYe-00057g-00@w-gerrit.beaverton.ibm.com> <20041129220047.GC19892@kroah.com> <527jo4s31r.fsf@topspin.com> <20041129223312.GA20667@kroah.com>
In-Reply-To: <20041129223312.GA20667@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Mon, Nov 29, 2004 at 02:28:32PM -0800, Roland Dreier wrote:
> 
>>    Greg> Ick.  Don't put a _t at the end of a typedef.  Wrong OS
>>    Greg> style guide.
>>
>>Just out of curiousity, who wrote the line
>>
>>	typedef int __bitwise kobject_action_t;
>>
>>in <linux/kobject_uevent.h>?  From the changelog it almost looks like
>>you did it ;)
> 
> 
> Yeah, at Linus's insistance.  See his email about the whole __bitwise
> stuff for that :(
> 
> But I did it for a simple variable type.  Not a structure.
> 
> /me justifies it to himself somehow...

And you are right to do so.  Typedefs for base types make a lot of
sense.  Just don't obfuscate structs with them.

-- 
~Randy
