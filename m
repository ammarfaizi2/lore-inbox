Return-Path: <linux-kernel-owner+w=401wt.eu-S932148AbXACVeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbXACVeP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbXACVeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:34:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:2102 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932148AbXACVeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:34:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FSYrCZMOGqDUn511Dh+P3jbAkWcBjeY+9RG8eYkkAr2jFZa0aIGMlzS9LKAyy/maxN82jvSx+oFgc12rw+k6SQdCsvgZOj13QSv+SijK8ErmLXdUuZvgwgY68Z7oUtHfFHII+QZcZVqPvi6HYS/w7i/DjFuYYVG1b68KYaheuSY=
Message-ID: <68676e00701031334t746eee57j9872528a16af30e2@mail.gmail.com>
Date: Wed, 3 Jan 2007 22:34:12 +0100
From: Luca <kronos.it@gmail.com>
To: "Gerhard Mack" <gmack@innerfire.net>
Subject: Re: [PATCH] radeonfb: add support for newer cards
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Andrew Morton" <akpm@osdl.org>, "Solomon Peachy" <pizza@shaftnet.org>,
       linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070101212551.GA19598@dreamland.darkstar.lan>
	 <20070101214442.GA21950@dreamland.darkstar.lan>
	 <1167696853.23340.156.camel@localhost.localdomain>
	 <68676e00701011638h55264e00g16504b0e3acdad7f@mail.gmail.com>
	 <Pine.LNX.4.64.0701031556370.5730@mtl.rackplans.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/07, Gerhard Mack <gmack@innerfire.net> wrote:
> On Tue, 2 Jan 2007, Luca wrote:
>
> > Date: Tue, 2 Jan 2007 01:38:17 +0100
> > From: Luca <kronos.it@gmail.com>
> > To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Andrew Morton <akpm@osdl.org>, Solomon Peachy <pizza@shaftnet.org>,
> >     linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
> > Subject: Re: [PATCH] radeonfb: add support for newer cards
> >
> > On 1/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > > On Mon, 2007-01-01 at 22:44 +0100, Luca Tettamanti wrote:
> > > > Il Mon, Jan 01, 2007 at 10:25:51PM +0100, Luca Tettamanti ha scritto:
> > > > > Hi Ben, Andrew,
> > > > > I've rebased 'ATOM BIOS patch' from Solomon Peachy to apply to 2.6.20.
> > > > > The patch adds support for newer Radeon cards and is mainly based on
> > > > > X.Org code.
> > > >
> > > > And - for an easier review - this is the diff between
> > > > radeonfb-atom-2.6.19-v6a.diff from Solomon and my patch (whitespace-only
> > > > changes not included).
> > >
> > > Ah good, what I was asking for :-) I'll try to get a new patch combining
> > > everything out asap.
> >
> > Great, I didn't know you were working on this, I feared that the patch
> > had been forgotten.
> > I've a X850 (R480) here, feel free to send me any patch for testing.
>
> Is there a list of cards this adds support for?  I'm waiting on support
> for the X1600

The patch is for the "old" generation, R400, R480 and their mobile
versions. Unfortunately the new engine used in X1xxx cards is very
different and no docs are available from ATI.

Luca
