Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264269AbUDUB3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264269AbUDUB3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 21:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbUDUB3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 21:29:46 -0400
Received: from dsl081-240-014.sfo1.dsl.speakeasy.net ([64.81.240.14]:36307
	"EHLO tumblerings.org") by vger.kernel.org with ESMTP
	id S264269AbUDUB3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 21:29:43 -0400
Date: Tue, 20 Apr 2004 18:29:33 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: Andy Isaacson <adi@bitmover.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: matching "Cset exclude" changelog entries to the changelog entries they revert.
Message-ID: <20040421012933.GC16901@tumblerings.org>
References: <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org> <20040420174147.G21045@build.pdx.osdl.net> <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421003820.GB16901@tumblerings.org> <20040421001236.GA16901@tumblerings.org> <20040420172622.K22989@build.pdx.osdl.net> <20040421010226.GC27313@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421010226.GC27313@bitmover.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 06:02:26PM -0700, Andy Isaacson wrote:
> On Tue, Apr 20, 2004 at 05:26:22PM -0700, Chris Wright wrote:
> > * Zack Brown (zbrown@tumblerings.org) wrote:
> > > for instance, "Cset exclude: davej@suse.de|ChangeSet|20020403195622" is in
> > > 2.5.8-pre2, as the full text of the changelog entry.
> > 
> > bk prs -r"davej@suse.de|ChangeSet|20020403195622" -hnd:REV: ChangeSet
> > 
> > That will give you the rev from that key in the Cset exclude message.
> 
> You can use cset keys just about anywhere you can use revision numbers
> in the BK interface.  So,
> % bk changes -r'davej@suse.de|ChangeSet|20020403195622'
> does the right thing.
> 
> On Tue, Apr 20, 2004 at 05:38:20PM -0700, Zack Brown wrote:
> > Will this give me the text of the changelog entry being reverted? That's
> > what I need to find.
> 
> The "changes" command I give above will.
> 
> I'll see if I can get the "cset exclude" text to be an HREF.  In the

That would be nice.

> meantime, you can construct a working URL by appending the cset key to 
> http://linux.bkbits.net:8080/linux-2.5/cset@
> 
> like so:
> http://linux.bkbits.net:8080/linux-2.5/cset@davej@suse.de|ChangeSet|20020403195622

This is perfect! Just what I was looking for.

Thanks Andy and Chris!
Zack

> 
> -andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Zack Brown
