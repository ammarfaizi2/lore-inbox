Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313537AbSD3NgF>; Tue, 30 Apr 2002 09:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313555AbSD3NgE>; Tue, 30 Apr 2002 09:36:04 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:59402 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S313537AbSD3NgC>; Tue, 30 Apr 2002 09:36:02 -0400
Date: Tue, 30 Apr 2002 23:37:32 +1000
From: john slee <indigoid@higherplane.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-ID: <20020430133732.GB22705@higherplane.net>
In-Reply-To: <20020429192107.GA26369@louise.pinerecords.com> <26170.1020121574@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 09:06:14AM +1000, Keith Owens wrote:
> Solution:
> 
>   modutils 2.4.16 says
> 
>   Warning: loading <module> will taint the kernel.  Reason <reason>
>     See <TAINT_URL> for information on tainted modules
>   Module loaded, with warnings
> 
>   Printing 'Module loaded, with warnings' makes it clear that the
>   module has been loaded.  TAINT_URL defaults to lkml FAQ.  Vendors can
>   ship modutils with a TAINT_URL that points to their support policy.

how about adding an optional tag to modules for a support/faq URL?
there's no real need to add it for stuff in the kernel tree (unlike the
license tag stuff) but external projects could make good use of it.
sounds much better to me than arguing over the subtleties of the warning
message.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
