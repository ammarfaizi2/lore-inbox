Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVAEPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVAEPNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVAEPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:12:52 -0500
Received: from [213.146.154.40] ([213.146.154.40]:60052 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262465AbVAEPLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:11:42 -0500
Date: Wed, 5 Jan 2005 15:11:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050105151133.GA2021@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de,
	linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
	gordon.jin@intel.com, alsa-devel@lists.sourceforge.net,
	greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il> <20050105144603.GA1419@infradead.org> <20050105150310.GA19758@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105150310.GA19758@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 05:03:10PM +0200, Michael S. Tsirkin wrote:
> I dont know. So how will people know they are supposed to convert then?

Tell the janitors about it - or do it yourself.  Except for taking care
of the BKL going away it's a trivial conversion.

