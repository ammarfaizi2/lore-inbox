Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUEJW3e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUEJW3e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbUEJW3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:29:33 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:47305 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261992AbUEJW3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:29:08 -0400
Date: Tue, 11 May 2004 08:28:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, LKML <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] 2.6.6 Have XFS use kernel-provided qsort
Message-ID: <20040511082824.A320049@wobbly.melbourne.sgi.com>
References: <20040510050905.GB13889@taniwha.stupidest.org> <20040510125636.GJ9028@fs.tum.de> <20040510171512.GB12314@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040510171512.GB12314@taniwha.stupidest.org>; from cw@f00f.org on Mon, May 10, 2004 at 10:15:12AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:15:12AM -0700, Chris Wedgwood wrote:
> On Mon, May 10, 2004 at 02:56:36PM +0200, Adrian Bunk wrote:
> 
> > This results in an empty file being left.
> 
> True, but it is/way mostly for illustrative purposes anyhow since XFS
> changes end up going in via ptools some futzing would be required
> anyhow.

For this kind of thing (i.e. with core kernel change outside XFS)
we've usually sent these via Andrew as patches (not the ptools/bk
dance) - could you fix and resend?  Your change looks fine to me.
The other user I think is Andreas' NFS ACL patches, but I may be
wrong there, haven't looked closely enough.

thanks.

-- 
Nathan
