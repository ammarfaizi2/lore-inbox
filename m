Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317564AbSGZKO6>; Fri, 26 Jul 2002 06:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSGZKO5>; Fri, 26 Jul 2002 06:14:57 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:36877 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317564AbSGZKOl>; Fri, 26 Jul 2002 06:14:41 -0400
Date: Fri, 26 Jul 2002 11:17:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: martin@dalecki.de
Cc: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
       linux-kernel@vger.kernel.org, mge@sistina.com
Subject: Re: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020726111752.A8734@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, martin@dalecki.de,
	"Heinz J . Mauelshagen" <mauelshagen@sistina.com>,
	linux-kernel@vger.kernel.org, mge@sistina.com
References: <20020725153944.A8060@sistina.com> <20020725155433.A12776@infradead.org> <3D409C3C.8090009@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D409C3C.8090009@evision.ag>; from dalecki@evision.ag on Fri, Jul 26, 2002 at 02:47:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2002 at 02:47:56AM +0200, Marcin Dalecki wrote:
> Or of course the normal u8 u16 and u32 and infally u64, which are so
> much more explicit about the fact that we are actually dealig with
> bit slices.

*nod*

> > All in all this patch would be _soooo_ much easier to review if you wouldn't
> > mix random indentation changes with real fixes.
> 
> Christoph applying the patch and rediffing with diffs "ingore white 
> space' options can help you here.

It's not that easy - he randomly moves the conditional statements on the
if or else lines and changes brace placement..

> And plese note that this kind of problems wouldn't be that common
> if we finally decided to make indent -kr -i8 mandatory.

nightly run on the bk repo...  Larry, is that possible? :)

<advertise>
for all those who want an indent with sane defaults:

version 0.2 of the 'portable' version of NetBSD is now available.
get it from https://developer.berlios.de/project/filelist.php?group_id=192
and package it for $DISTRO.

feedback welcome.
</advertise>
