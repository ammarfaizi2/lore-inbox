Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262575AbTLBRja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 12:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTLBRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 12:39:30 -0500
Received: from as13-5-5.has.s.bonet.se ([217.215.179.23]:50902 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262575AbTLBRj2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 12:39:28 -0500
Message-ID: <3FCCCED2.1090706@stesmi.com>
Date: Tue, 02 Dec 2003 18:41:38 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Darrell Michaud <dmichaud@wsi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Russell Cattelan <cattelan@xfs.org>, Nathan Scott <nathans@sgi.com>,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: XFS for 2.4
References: <Pine.LNX.4.44.0312021346530.13692-100000@logos.cnet> <1070381443.5316.260.camel@atherne> <20031202162808.GC22608@gtf.org>
In-Reply-To: <20031202162808.GC22608@gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> On Tue, Dec 02, 2003 at 11:10:43AM -0500, Darrell Michaud wrote:
> 
>>As a user it would be very beneficial for me to have XFS support in the
>>official 2.4 kernel tree. XFS been stable and "2.4 integration-ready"
>>for a long time, and 2.4 is going to be used in certain environments for
>>a long time, if only because it's easier to upgrade a 2.4 kernel to a
>>newer 2.4 kernel than to upgrade to a 2.6 kernel. It seems like an easy
>>case to make.
>>
>>I use other filesystems and some funky drivers as well.. and I'm always
>>very happy to see useful backports show up in the 2.4 tree. Thank you!
> 
> 
> This can also be done in patch form, as it is done now :)
> 
> There are several pieces of backported software that are
> integration-ready, but that doesn't imply they should go into an
> increasingly-frozen 2.4.x tree...

Good point, however the XFS code has been ready for way longer
than some other things that were integrated have existed at all.

There was a question to merge XFS before 2.4 but the answer was no
then. That was eons ago and reiserfs and JFS has made it in since then
but not XFS. That strikes me as odd. Everybody have been patient and
changing the code according to how it might get accepted and it still
hasn't been merged. Many people have run XFS for a long time and while
they can use the same way they do now (xfs-patches or precompiled RPM)
I don't see a motivation not to include it, especially seeing that
other filesystems got in. True XFS touches some generic code but
if that really is an issue, why don't people sit down and look at the
changes (again) and see what can be changed. If that's the reason.

// Stefan

