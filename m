Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVAEOqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVAEOqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVAEOqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:46:16 -0500
Received: from [213.146.154.40] ([213.146.154.40]:23956 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262118AbVAEOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:46:10 -0500
Date: Wed, 5 Jan 2005 14:46:03 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>, mingo@elte.hu,
       rlrevell@joe-job.com, tiwai@suse.de, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: Re: [PATCH] deprecate (un)register_ioctl32_conversion
Message-ID: <20050105144603.GA1419@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>,
	Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
	mingo@elte.hu, rlrevell@joe-job.com, tiwai@suse.de,
	linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
	gordon.jin@intel.com, alsa-devel@lists.sourceforge.net,
	greg@kroah.com
References: <20041215065650.GM27225@wotan.suse.de> <20041217014345.GA11926@mellanox.co.il> <20050105144043.GB19434@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050105144043.GB19434@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2005 at 04:40:43PM +0200, Michael S. Tsirkin wrote:
> Hello, Andrew, all!
> 
> Since in -mm1 we now have a race-free replacement (that being ioctl_compat),
> here is a patch to deprecate (un)register_ioctl32_conversion.

Sorry, but this is a lot too early.  Once there's a handfull users left
in _mainline_ you can start deprecating it (or better remove it completely).

So far we have a non-final version of the replacement in -mm and no single
user converted.

