Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbUBYSjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUBYSjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:39:42 -0500
Received: from fed1mtao01.cox.net ([68.6.19.244]:1720 "EHLO fed1mtao01.cox.net")
	by vger.kernel.org with ESMTP id S261540AbUBYSjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:39:36 -0500
Date: Wed, 25 Feb 2004 11:39:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mundt <lethal@linux-sh.org>, "James H. Cloos Jr." <cloos@jhcloos.com>,
       linux-kernel@vger.kernel.org
Subject: Re: make help ARCH=xx fun
Message-ID: <20040225183934.GX1052@smtp.west.cox.net>
References: <m3y8qwv78e.fsf@lugabout.jhcloos.org> <20040222095021.GB2266@mars.ravnborg.org> <20040224215548.GF1052@smtp.west.cox.net> <20040225190049.GB2474@mars.ravnborg.org> <20040225180858.GW1052@smtp.west.cox.net> <20040225183038.GA24041@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225183038.GA24041@linux-sh.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 01:30:38PM -0500, Paul Mundt wrote:
> On Wed, Feb 25, 2004 at 11:08:59AM -0700, Tom Rini wrote:
> > I can understand that.  How about:
> > for board in arch/$(ARCH)/configs/*defconfig; \
> >  do \
> >    if [ -f $board ]; then
> >     ...
> >    fi
> >  done
> > 
> Simply just matching on *defconfig should be fine. I already changed this on
> matching defconfig-* for sh to get around matching SCCS.

Would you mind changing to foo_defconfig from defconfig-foo ?  Then you
get the make foo_defconfig rule for free.

-- 
Tom Rini
http://gate.crashing.org/~trini/
