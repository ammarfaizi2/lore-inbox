Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSIBM1H>; Mon, 2 Sep 2002 08:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318286AbSIBM1F>; Mon, 2 Sep 2002 08:27:05 -0400
Received: from pc-80-195-6-65-ed.blueyonder.co.uk ([80.195.6.65]:56961 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S318282AbSIBM1D>; Mon, 2 Sep 2002 08:27:03 -0400
Date: Mon, 2 Sep 2002 13:30:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Dave Jones <davej@suse.de>, Andrew Morton <akpm@zip.com.au>,
       Jani Monoses <jani@iv.ro>, linux-kernel@vger.kernel.org
Cc: Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] 2.5.32 : u.ext3_sb -> generic_sbp
Message-ID: <20020902133059.B4105@redhat.com>
References: <Pine.LNX.4.21.0001010429580.1200-100000@localhost.localdomain> <3D6FC178.CC3E89CD@zip.com.au> <20020831181338.A28204@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020831181338.A28204@suse.de>; from davej@suse.de on Sat, Aug 31, 2002 at 06:13:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 31, 2002 at 06:13:38PM +0200, Dave Jones wrote:
> On Fri, Aug 30, 2002 at 12:03:20PM -0700, Andrew Morton wrote:
>  > > This turns the remaining parts of ext3 to EXT3_SB and turns the latter
>  > > from a macro to inline function which returns the generic_sbp field of u.
>  > Thanks.
>  > It's not going to make the merge of all Stephen's 2.4 changes
>  > any more fun though ;)
> 
> The last 2.5-dj I did should be in sync as of ext3 in 2.4.19,
> but lacks the bits sct came up with recently for 2.4.20pre.[1]

I think akpm's been grabbing the most important bits of that anyway.

--Stephen
