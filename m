Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbVDFRYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbVDFRYH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 13:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVDFRYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 13:24:07 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:15890 "EHLO
	smtp-vbr7.xs4all.nl") by vger.kernel.org with ESMTP id S262263AbVDFRYD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 13:24:03 -0400
In-Reply-To: <20050406154648.GA28638@kroah.com>
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl> <200504052053.20078.blaisorblade@yahoo.it> <7aa6252d5a294282396836b1a27783e8@xs4all.nl> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl> <20050406122750.GE7031@wohnheim.fh-wedel.de> <20050406154648.GA28638@kroah.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c9f1f9c86f38a0dc3ff50ac93d2f9979@xs4all.nl>
Content-Transfer-Encoding: 7bit
Cc: jdike@karaya.com, Blaisorblade <blaisorblade@yahoo.it>,
       linux-kernel@vger.kernel.org, J?rn Engel <joern@wohnheim.fh-wedel.de>,
       stable@kernel.org
From: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [stable] Re: [08/08] uml: va_copy fix
Date: Wed, 6 Apr 2005 19:29:46 +0200
To: Greg KH <gregkh@suse.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 6, 2005, at 5:46 PM, Greg KH wrote:

> On Wed, Apr 06, 2005 at 02:27:51PM +0200, J?rn Engel wrote:
>>
>> Is it worth the effort?  Not sure.  But the "it's old, drop support
>> for it" argument just doesn't cut it and it doesn't get any better by
>> repetition.

However, the argument gets better every time "a workaround" is needed. 
If there are still serious issues
open (like a failure to catch bugs the old version did), they are 
issues which need resolving in the
compiler. Patching the wrong project, is introducing two imperfections.

I think its worth the time and trouble to take this up with the gcc 
crowd. So if you could provide a list of things 3.3 misses, i'm sure 
the gcc-crowd would like it.

> Exactly, that's why this patch is valid.

At the very least, it's at the wrong place, since it should be patched 
in ./include/linux/compiler.h. And I do not exactly argue "it's old, 
drop support for it", but rely on the "dont rely on compiler internals 
or at least stick them on one place where everyone can find them 
easily, instead of peppering the entire codebase with them" argument.

Regards,

Renate Meijer.

