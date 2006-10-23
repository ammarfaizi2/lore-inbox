Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964942AbWJWPcX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbWJWPcX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWJWPcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:32:23 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:54708 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964942AbWJWPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:32:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F5XjkvMMdLbNWO1p2GYnccxMVtR9TjduavNqMMYlt0BrBFZIpqm1YeoCdJpf8H8ytyw7KDvDQid2e/NFPhGOf3C50HewfGzQJM3yHhlXB2YPdLN2tywkFs3dzE7ez9kU/GK29PdaPDY6G0YQNQRPu2/sSk0UAfeizTSdnDzlV2w=
Message-ID: <ceccffee0610230832l4eb76b0dvd1c4c275ae462d3d@mail.gmail.com>
Date: Mon, 23 Oct 2006 17:32:21 +0200
From: "Linux Portal" <linportal@gmail.com>
To: "Theodore Tso" <tytso@mit.edu>, "Linux Portal" <linportal@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: First benchmarks of the ext4 file system
In-Reply-To: <20061023020731.GA486@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <ceccffee0610211657u66b758b7r78fbf1c75f5dea67@mail.gmail.com>
	 <20061023020731.GA486@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/06, Theodore Tso <tytso@mit.edu> wrote:
> On Sun, Oct 22, 2006 at 01:57:36AM +0200, Linux Portal wrote:
> > ext4 is 20 percent faster writer than ext3 or reiser4, probably thanks
> > to extents and delayed allocation. On other tests it is either
> > slightly faster or slightly slower. reiser4 comes as a nice surprise,
> > winning few benchmarks. Both are very stable, no errors during
> > testing.
>
> As Andrew has already pointed out, we don't have delayed allocation
> merged in into the -mm tree yet.

OK.

> If you have the
> time/energy/interest, a very useful thing that would very much help
> the filesystem developers of all filesystems to do would be to
> automated your tesitng enough that you can do these tests on a
> frequent basis, both to track regressions caused by changes in other
> parts of the kernel, as well we to see what happens as various bits of
> functionality get added to the filesystem.  This of course can become
> an arbitrarily a huge amount of work, as you add more filesystems and
> benchmarks, but it's the sort of thing which is incredibly useful
> especially if the hardware is held constant across a large number of
> filesystems, workloads/benchmarks, and kernel versions.
>

I agree completely. That was my original idea, to prepare some setup for
thorough testing, but I soon discovered that would really be a huge project,
because of so many parameters involved.

So, at this time, I just satisfied my curiosity ;) with few simple tests of the
early version of ext4. We'll see what the future brings (how much free
time, in the first place ;)).

Best regards,
