Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTELWHr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbTELWHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:07:46 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:27922 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262884AbTELWHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:07:41 -0400
Date: Mon, 12 May 2003 23:20:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Christoph Hellwig <hch@infradead.org>, davidm@hpl.hp.com,
       michel@daenzer.net, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
Message-ID: <20030512232008.A17729@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@digeo.com>, davidm@hpl.hp.com,
	michel@daenzer.net, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
References: <16062.37308.611438.5934@napali.hpl.hp.com> <20030511195543.GA15528@suse.de> <1052690133.10752.176.camel@thor> <16063.60859.712283.537570@napali.hpl.hp.com> <1052768911.10752.268.camel@thor> <16064.453.497373.127754@napali.hpl.hp.com> <1052774487.10750.294.camel@thor> <16064.5964.342357.501507@napali.hpl.hp.com> <20030512225728.A17182@infradead.org> <20030512150831.5bf2e14c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030512150831.5bf2e14c.akpm@digeo.com>; from akpm@digeo.com on Mon, May 12, 2003 at 03:08:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that the 2.4 vmap implementation in the XFS tree doesn't have this problem.
It's cludged into the old vmalloc design instead of beeing based on Linus'
suggestion whiches buggy implementation (by me) opened this race.
