Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWEINNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWEINNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 09:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWEINNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 09:13:25 -0400
Received: from roadrunner-base.egenera.com ([63.160.166.46]:12428 "EHLO
	roadrunner-base.egenera.com") by vger.kernel.org with ESMTP
	id S932503AbWEINNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 09:13:24 -0400
Date: Tue, 9 May 2006 09:11:21 -0400
From: "Philip R. Auld" <pauld@egenera.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GPL-only symbols issue
Message-ID: <20060509131121.GJ30333@vienna.egenera.com>
References: <445F0B6F.76E4.0078.0@novell.com> <20060509042500.GA4226@kroah.com> <1147154238.7203.62.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147154238.7203.62.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Rumor has it that on Mon, May 08, 2006 at 10:57:18PM -0700 Ram Pai said:
> On Mon, 2006-05-08 at 21:25 -0700, Greg KH wrote:
> > On Mon, May 08, 2006 at 09:12:15AM +0200, Jan Beulich wrote:
> > > Sam,
> > > 
> > > would it seem reasonable a request to detect imports of GPL-only
> > > symbols by non-GPL modules also at build time rather than only at run
> > > time, and at least warn about such?
> > 
> > Ram has some tools that might catch this kind of thing.  He's posted his
> > scripts to lkml in the past, try looking in the archives.
> 
> The patches are at
> 
> http://sudhaa.com/~ram/misc/kernelpatch
> 
> The patch of interest for you would be modpost.patch
> I have a script and some code that can poke into a given .ko file and
> warn against symbols that don't match what the kernel exports. 
> 
> I can post that code if there is interest in that functionality,

I'd love to see it. 

Thanks,

Phil

> RP
> 
> > 
> > thanks,
> 
> > greg k-h
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
