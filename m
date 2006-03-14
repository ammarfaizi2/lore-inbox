Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWCNP3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWCNP3D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCNP3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:29:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:61391 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750714AbWCNP3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:29:01 -0500
Date: Tue, 14 Mar 2006 15:29:00 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stone, Joshua I" <joshua.i.stone@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Exports for hrtimer APIs
Message-ID: <20060314152900.GD16921@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stone, Joshua I" <joshua.i.stone@intel.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A48C31@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBDB88BFD06F7F408399DBCF8776B3DC06A48C31@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 02:00:16PM -0800, Stone, Joshua I wrote:
> Hi,
> 
> I have noticed that the hrtimer APIs in 2.6.16 RCs are not exported, and
> therefore modules are unable to use hrtimers.  I have not seen any
> discussion on this point, so I presume that this is either an oversight,
> or there has not been any case presented for exporting hrtimers.
> 
> I would like to add hrtimer support to SystemTap, which by design
> requires the use of dynamically loaded kernel modules.  Can the
> appropriate exports for hrtimers please be added?

NACK.  We only add exports when they are a) sensible and b) are used in
kernel.

If you guys want to keep your code out of tree that's your problem.
