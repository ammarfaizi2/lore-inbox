Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292965AbSBVTkD>; Fri, 22 Feb 2002 14:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSBVTj4>; Fri, 22 Feb 2002 14:39:56 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:10379
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S292965AbSBVTjr>; Fri, 22 Feb 2002 14:39:47 -0500
Date: Fri, 22 Feb 2002 12:37:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@caldera.de>, lm@bitmover.com, hpa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 bitkeeper repository
Message-ID: <20020222193723.GL719@opus.bloom.county>
In-Reply-To: <20020222160657.A7914@caldera.de> <Pine.LNX.4.33L.0202221625480.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202221625480.7820-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 04:26:42PM -0300, Rik van Riel wrote:
> On Fri, 22 Feb 2002, Christoph Hellwig wrote:
> 
> > the Linux 2.4 repository at linux.bkbbits.net is orphaned short after
> > it got created.  Ist there any chance we could see continguous checkins
> > for it?
> >
> > I think it might be a good idea to get it automatically checked in once
> > Marcelo uploads a new (pre-) patch as part of the kernel.org
> > notification procedure (is this possible, Peter?).
> >
> > If there is no way to automate it I would volunteer to do the checkins,
> > but for that I'd need write permissions to the repository.
> 
> I've got a script here which pretty much automates the
> checkins of incremental patches, it should be trivial
> for Peter to call that from his script that creates the
> incremental diffs.

If you have a pristine tree, adding incremental diffs is:
bk import -tpatch ../patch-2.4.X-preY-preZ . && bk tag v2.4.X-preZ
Which is what I do for the PPC's kernel.org-only tree(s).

Larry or Cort Dougan came up w/ a script ages ago to do it w/o
incrmenetal diffs and to make a backup as well.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
