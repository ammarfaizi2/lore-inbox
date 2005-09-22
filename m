Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbVIVRJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbVIVRJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 13:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030453AbVIVRJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 13:09:48 -0400
Received: from xenotime.net ([66.160.160.81]:12175 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030454AbVIVRJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 13:09:47 -0400
Date: Thu, 22 Sep 2005 10:09:45 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Harald Welte <laforge@netfilter.org>
cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update Documentation/sparse.txt
In-Reply-To: <20050922170009.GP26520@sunbeam.de.gnumonks.org>
Message-ID: <Pine.LNX.4.58.0509221008100.20059@shark.he.net>
References: <20050921170539.GA10537@mipter.zuzino.mipt.ru>
 <20050922132833.GM26520@sunbeam.de.gnumonks.org> <20050922153451.GA7519@mipter.zuzino.mipt.ru>
 <20050922170009.GP26520@sunbeam.de.gnumonks.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Harald Welte wrote:

> On Thu, Sep 22, 2005 at 07:34:51PM +0400, Alexey Dobriyan wrote:
> > On Thu, Sep 22, 2005 at 03:28:34PM +0200, Harald Welte wrote:
> > > btw, where can I get the latest sparse release?
> > >
> > > linux-2.6.14-rc2/Documentation/sparse.txt still points to a dead
> > > directory at
> > > http://www.codemonkey.org.uk/projects/git-snapshots/sparse/
> > > which now seems to be 404.
> > >
> > > Are there no snapshots available?  Didn't anyone convre the bitkeeper
> > > repository to git or something else?  I'm a bit puzzled.
> >
> >
> > I use
> >
> > rsync -avz --progress --delete \
> > 	rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git/ \
> > 	.git
>
> Thanks.  Please consider this patch for the mainline kernel:
>
>
> [DOCUMENTATION] sparse no longer uses bk, but git
>
> Signed-off-by: Harald Welte <laforge@netfilter.org>
>
> ---
> commit 37df3d8b065579042d32a866ae6a00cd57c5812b
> tree dd0e013e4744201b2ae13b38e0186477fd2eb47d
> parent 0410f33b62b892379270539b189577126ea56ffe
> author Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 18:58:49 +0200
> committer Harald Welte <laforge@netfilter.org> Do, 22 Sep 2005 18:58:49 +0200
>
>  Documentation/sparse.txt |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
> --- a/Documentation/sparse.txt
> +++ b/Documentation/sparse.txt
> @@ -51,14 +51,9 @@ or you don't get any checking at all.
>  Where to get sparse
>  ~~~~~~~~~~~~~~~~~~~
>
> -With BK, you can just get it from
> -
> -        bk://sparse.bkbits.net/sparse
> -
> -and DaveJ has tar-balls at
> -
> -	http://www.codemonkey.org.uk/projects/git-snapshots/sparse/

Please leave Dave's snapshots dir. there even if you add the git method.
It is still present and working.
Thanks.

> +With git, you can just get it from
>
> +        rsync://rsync.kernel.org/pub/scm/devel/sparse/sparse.git
>
>  Once you have it, just do
>
>

-- 
~Randy
