Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261601AbVEAL05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbVEAL05 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 07:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEAL05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 07:26:57 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:24289 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261601AbVEAL0p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 07:26:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s6Af1MrmCoXjle7ELORve/vvKt6eABX1+EqUIV2/Lw+1UnW7LgzNY0zViFbG4+IgdgrVnKwWTRKD4zi77PLMjoCnLoDEQlsE0BseRARN7JymAbpDIx+48Rb2SMDZTNAyIuC2nlvw2CDW18uCLnhBKdKSH2gbirXx+AkEihN3pY8=
Message-ID: <9cde8bff05050104264aeeb365@mail.gmail.com>
Date: Sun, 1 May 2005 20:26:42 +0900
From: aq <aquynh@gmail.com>
Reply-To: aq <aquynh@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fs/Kconfig: more consistent configuration of XFS
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050430060923.GB3977@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9cde8bff050428005528ecf692@mail.gmail.com>
	 <20050428080914.GA10799@infradead.org>
	 <9cde8bff0504280138b979c08@mail.gmail.com>
	 <20050428083922.GA11542@infradead.org>
	 <9cde8bff05042802213ec650e0@mail.gmail.com>
	 <20050429212835.GD8699@mars.ravnborg.org>
	 <9cde8bff05042919025d077eb1@mail.gmail.com>
	 <20050430060923.GB3977@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sat, Apr 30, 2005 at 11:02:27AM +0900, aq wrote:
> >
> > >
> > > About your modifications:
> > >
> > > Skipping the menu part is OK.
> > > While you are modifying Kconfig in xfs/ put a
> > >
> > > if XFS_FS
> > > ...
> > > endif
> > >
> > > around all config options expcept the one defining the XFS_FS option.
> > > This will fix menu identing.
> >
> > Thanks for pointing this out. But the patch I posted is fair enough.
> > It just move one menu item around, and change nothing else. Are you
> > happy with it?
> If indention is OK for all menu entries in XFS - yes. Otherwise not.

I have tested it. Identation is fine.

regards,
aq
