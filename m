Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268186AbTBNFmx>; Fri, 14 Feb 2003 00:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268188AbTBNFmx>; Fri, 14 Feb 2003 00:42:53 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:57359 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268186AbTBNFmw>; Fri, 14 Feb 2003 00:42:52 -0500
Date: Fri, 14 Feb 2003 05:52:44 +0000
From: "'Christoph Hellwig '" <hch@infradead.org>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: "'jsimmons@infradead.org '" <jsimmons@infradead.org>,
       "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) consol e
Message-ID: <20030214055244.A18305@infradead.org>
Mail-Followup-To: 'Christoph Hellwig ' <hch@infradead.org>,
	Osamu Tomita <tomita@cinet.co.jp>,
	"'jsimmons@infradead.org '" <jsimmons@infradead.org>,
	'Linux Kernel Mailing List ' <linux-kernel@vger.kernel.org>,
	'Alan Cox ' <alan@lxorguk.ukuu.org.uk>
References: <E6D19EE98F00AB4DB465A44FCF3FA46903A332@ns.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E6D19EE98F00AB4DB465A44FCF3FA46903A332@ns.cinet.co.jp>; from tomita@cinet.co.jp on Fri, Feb 14, 2003 at 11:50:09AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 11:50:09AM +0900, Osamu Tomita wrote:
> > Please set CONFIG_KANJI in the Kconfig file and in general
> > the CONFIG_KANJI usere look really messy.  I don't think it's
> > easy to get them cleaned up before 2.6, you might get in contact
> > with James who works on the console layer to properly integrate them.
> I think too, CONFIG_KANJI needs cleanup.

I think the major point here is:  PC98 support does have a fair chance
to get into 2.6 (with a little bit more work).  Kanji console support
certainly won't go in.  Maybe you'll remove Kanji support for the
patchkit submitted for inclusion - this will make reviewing the rest
easier.

