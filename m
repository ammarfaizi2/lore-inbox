Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272927AbTHESbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272933AbTHESbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:31:12 -0400
Received: from bozo.vmware.com ([65.113.40.130]:8708 "EHLO mailout1.vmware.com")
	by vger.kernel.org with ESMTP id S272927AbTHESbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:31:06 -0400
Date: Tue, 5 Aug 2003 11:28:47 -0700
From: Christopher Li <chrisl@vmware.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, akpm@digeo.com, adilger@clusterfs.com,
       ext3-users@redhat.com, x86-kernel@gentoo.org
Subject: Re: [2.6] Perl weirdness with ext3 and HTREE
Message-ID: <20030805182847.GA20850@vmware.com>
References: <1059856625.14962.19.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059856625.14962.19.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can take a look at it.

Is there any way to reproduce this bug without installing the
whole gentoo? It would be nice if I can just download some
package to make it happen.

Thanks,

Chris


On Sat, Aug 02, 2003 at 10:37:05PM +0200, Martin Schlemmer wrote:
> Hi
> 
> I have mailed about this previously, but back then it was not
> really confirmed, so I have let it be at that.
> 
> Anyhow, problem is that for some reason 2.5/2.6 ext3 with HTREE
> support do not like what perl-5.8.0 does during installation.
> It *seems* like one of the temporary files created during manpage
> installation do not get unlinked properly, or gets into the
> hash (this possible?) and cause issues.
> 
> It seems to work flawless on 2.4 still.
> 
> Also, to be honest, I do not have that much free time these days,
> so if an interest in helping me/us debug this, it will be appreciated
> if some direction in what is needed/suggestions can be given as to what
> is required.  There are a few users that experience this issue, and
> I am sure that we can get whatever info needed.
> 
> A bug on our tracker is here with more (hopefully) complete info:
> 
>   http://bugs.gentoo.org/show_bug.cgi?id=24991
> 
> 
> Thanks,
> 
> -- 
> 
> Martin Schlemmer
> 
> 
> 




