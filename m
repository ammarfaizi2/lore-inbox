Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbTELVpf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbTELVpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:45:35 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:11538 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262771AbTELVpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:45:34 -0400
Date: Mon, 12 May 2003 22:57:28 +0100
From: Christoph Hellwig <hch@infradead.org>
To: davidm@hpl.hp.com
Cc: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030512225728.A17182@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
	=?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>,
	Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org,
	dri-devel@lists.sourceforge.net
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com> <1052653415.12338.159.camel@thor> <16062.37308.611438.5934@napali.hpl.hp.com> <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor> <16063.60859.712283.537570@napali.hpl.hp.com> <1052768911.10752.268.camel@thor> <16064.453.497373.127754@napali.hpl.hp.com> <1052774487.10750.294.camel@thor> <16064.5964.342357.501507@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16064.5964.342357.501507@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, May 12, 2003 at 02:51:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 02:51:08PM -0700, David Mosberger wrote:
> Is there someone else on this list who would be able to look into
> backporting vmap()/vunmap() to 2.4?  I don't use 2.4 with any
> regularity anymore, but I suppose if nobody else is interested, I
> could look into it.

I did that for the XFS tree ages ago, it's also in the -ac and -aa (the latter
still has the old three-arg version) now. I will submit it to Marcelo as soon
as 2.4.21 is out (so with the current 2.4 merge rate it'll be in in about 6 month..)

