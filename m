Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262273AbSJVHPg>; Tue, 22 Oct 2002 03:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262274AbSJVHPf>; Tue, 22 Oct 2002 03:15:35 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:8293 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S262273AbSJVHPf>; Tue, 22 Oct 2002 03:15:35 -0400
Date: Tue, 22 Oct 2002 10:21:32 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: can chroot be made safe for non-root?
Message-ID: <20021022072132.GN147946@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net> <87n0pevq5r.fsf@ceramic.fifi.org> <1035213732.27259.160.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035213732.27259.160.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 04:22:12PM +0100, you [Alan Cox] wrote:
> On Wed, 2002-10-16 at 07:44, Philippe Troin wrote:
> > > Is there a reason besides standards compliance that chroot() does not
> > > already change directory to the chroot'd directory for root processes?
> > > Would it actually break existing apps if it did change the directory?
> > 
> > Probably not. Make that: change the directory to chroot'd directory if
> > the current working directory is outside the chroot. That is, leave
> > the cwd alone if it is already inside the chroot.
> 
> Last time it was tried real apps broke.
> 
> chroot is not jail chroot is not a sandbox. Do the job right (eg the
> vroot work) and it'll get a lot further

vserver (http://www.solucorp.qc.ca/miscprj/s_context.hc) seems to work
pretty decently. It's somewhat similar to bsd's jail.


-- v --

v@iki.fi
