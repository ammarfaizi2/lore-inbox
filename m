Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLZQTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 11:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTLZQTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 11:19:53 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:3855 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263221AbTLZQTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 11:19:52 -0500
Date: Fri, 26 Dec 2003 16:19:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
Message-ID: <20031226161949.A31900@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Andreas Jellinghaus <aj@dungeon.inka.de>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur> <20031223163904.A8589@infradead.org> <pan.2003.12.25.17.47.43.603779@dungeon.inka.de> <20031225184553.A25397@infradead.org> <1072381287.7638.52.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1072381287.7638.52.camel@nosferatu.lan>; from azarah@nosferatu.za.org on Thu, Dec 25, 2003 at 09:41:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 09:41:28PM +0200, Martin Schlemmer wrote:
> So maybe suggest an solution rather than shooting one down all the
> time (which do seem logical, and is only apposed by one person currently
> - namely you =).

My suggestion is to just use MAKEDEV asis for devices that are static
like the memdevices.  Dynamic solutions do not buy us anything for those.

