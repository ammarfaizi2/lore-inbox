Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266892AbRGMUYq>; Fri, 13 Jul 2001 16:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbRGMUYg>; Fri, 13 Jul 2001 16:24:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35428 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266892AbRGMUY2>; Fri, 13 Jul 2001 16:24:28 -0400
To: John Clemens <john@deater.net>
Cc: Dave Jones <davej@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: BIOS, Duron4 specifics...
In-Reply-To: <Pine.LNX.4.33.0107101222560.13575-100000@pianoman.cluster.toy>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jul 2001 14:19:00 -0600
In-Reply-To: <Pine.LNX.4.33.0107101222560.13575-100000@pianoman.cluster.toy>
Message-ID: <m1pub44m6j.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Clemens <john@deater.net> writes:

> On Tue, 10 Jul 2001, Dave Jones wrote:
> 
> > On Tue, 10 Jul 2001, John Clemens wrote:
> >
> > > I've got a new laptop with an AMD Duron in it, based on the Athlon4 core
> > > (PowerNow, SSE, hardware prefetch, etc.. Palomino core)..  However, it
> > > appears none of the useful features are enabled in the bios.  For example,
> > > Nowhere does it appear to enable SSE or the APIC.
> >
> > afair, the mobile Durons are not based upon the Athlon 4 core, and
> > hence won't have the features you mention. You can verify this with
> > my x86info tool which you can get from
> > ftp://ftp.suse.com/pub/people/davej/x86info/x86info-1.3.tgz
> 
> Actually, CPUID reports Family 6, Model 6, Rev2, which corellates directly
> to Athlon4/MP (Model 6) processors.  Whats surprising is that is doesn't
> report model 7, which AMD claims is supposed to be the mobile Duron ;)..
> make me wonder if it's really a neutered Athlon4.  Besides, I though the
> origional mobile durons (T-bird core, model 3) didn't even support
> powernow...?

To enable SSE you have to write a bit into a undocumented register.
For the APIC the procedure to enable it is the same as the P6 core.

Eric
