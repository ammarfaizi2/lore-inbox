Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265182AbTLZQy5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 11:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbTLZQy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 11:54:57 -0500
Received: from mother.ds.pg.gda.pl ([153.19.213.213]:44941 "HELO
	mother.ds.pg.gda.pl") by vger.kernel.org with SMTP id S265182AbTLZQy4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 11:54:56 -0500
Date: Fri, 26 Dec 2003 17:54:56 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@nosferatu.za.org>,
       Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031226165456.GA26466@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Andreas Jellinghaus <aj@dungeon.inka.de>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org> <pan.2003.12.25.17.47.43.603779@dungeon.inka.de> <20031225184553.A25397@infradead.org> <1072381287.7638.52.camel@nosferatu.lan> <20031226161949.A31900@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031226161949.A31900@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 26, 2003 at 04:19:49PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 25, 2003 at 09:41:28PM +0200, Martin Schlemmer wrote:
> > So maybe suggest an solution rather than shooting one down all the
> > time (which do seem logical, and is only apposed by one person currently
> > - namely you =).
> 
> My suggestion is to just use MAKEDEV asis for devices that are static
> like the memdevices.  Dynamic solutions do not buy us anything for those.

 They do buy when using tmpfs for /dev.

-- 
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other. 
