Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWHGXZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWHGXZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHGXZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:25:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:3817 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932249AbWHGXZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:25:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CSu/L97oh3Hoz27WkO/uJjcSTwfFmW9xdTSVMm5FYfKx4R99TPhizqLr54LmRZR2tjWi1u8aIwgSyK80sGSISJiNknXBRv/CQMxmljbrljg/3ZGqwP/fGeJ86RflD1IfjWYiL+nN+TNASFgbFsKnGsiwp49/fhgrb4jSwZIQsnU=
Message-ID: <5c49b0ed0608071614k3a62a982jbe27fa0c6d5fdb0@mail.gmail.com>
Date: Mon, 7 Aug 2006 16:14:59 -0700
From: "Nate Diller" <nate.diller@gmail.com>
To: "Jens Axboe" <axboe@suse.de>
Subject: Re: [PATCH -mm] [1/3] add elv_extended_request call to iosched API
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060804133938.GX20624@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5c49b0ed0608031911id21b112t7f0c350a7f10a99@mail.gmail.com>
	 <20060804052031.GA4717@suse.de>
	 <20060803224519.dd9bf38e.akpm@osdl.org>
	 <20060804133938.GX20624@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Jens Axboe <axboe@suse.de> wrote:
> On Thu, Aug 03 2006, Andrew Morton wrote:
> > On Fri, 4 Aug 2006 07:20:32 +0200
> > Jens Axboe <axboe@suse.de> wrote:
> >
> > > On Thu, Aug 03 2006, Nate Diller wrote:
> > > > the Elevator iosched would prefer to be unconditionally notified of a
> > > > merge, but the current API calls only one 'merge' notifier
> > > > (elv_merge_requests or elv_merged_requests), even if both front and
> > > > back merges happened.
> > > >
> > > > elv_extended_request satisfies this requirement in conjunction with
> > > > elv_merge_requests.
> > >
> > > Ok, I suppose. But please rebase patches against the 'block' git branch,
> > > there are extensive changes in this area.
> > >
> >
> > argh, the great (but partial ;)) renaming bites again.
> >
> > A suitable patch to merge against is
> > http://www.zip.com.au/~akpm/linux/patches/stuff/git-block.patch
>
> not so much the renaming (that's easy enough), but the elevator core
> parts changed in some areas.

would it be appropriate to submit against 2.6.18-rc3-mm2?  I hope to
have a much-cleaned-up version tomorrow

thanks

NATE
