Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTCVOEU>; Sat, 22 Mar 2003 09:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262781AbTCVOEU>; Sat, 22 Mar 2003 09:04:20 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:13065 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262780AbTCVOET>; Sat, 22 Mar 2003 09:04:19 -0500
Date: Sat, 22 Mar 2003 14:15:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: PATCH: fix proc handling in sis, siimageand slc90e66
Message-ID: <20030322141522.A26332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk> <20030322074911.A24305@infradead.org> <1048345386.8911.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1048345386.8911.13.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 22, 2003 at 03:03:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 22, 2003 at 03:03:06PM +0000, Alan Cox wrote:
> On Sat, 2003-03-22 at 07:49, Christoph Hellwig wrote:
> > > +	
> > > +	return len > count ? count : len;
> > 
> > Shouldn't this just move to the seq_file interface?  (probably the "simple"
> > variant)
> 
> That means making the 2.4 and 2.5 drives diverge which is a pain I don't want 
> before 2.6

The seq_file interface is already and a backport of the single stuff is
trivial and should happen anyway.
