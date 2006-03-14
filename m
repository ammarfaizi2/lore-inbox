Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWCNWDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWCNWDp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWCNWDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:03:44 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47516 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964794AbWCNWDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:03:43 -0500
Date: Tue, 14 Mar 2006 22:03:39 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Stone, Joshua I" <joshua.i.stone@intel.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] provide hrtimer exports for module use [Was: Exports for hrtimer APIs]
Message-ID: <20060314220339.GA25207@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	"Stone, Joshua I" <joshua.i.stone@intel.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <CBDB88BFD06F7F408399DBCF8776B3DC06A92A13@scsmsx403.amr.corp.intel.com> <20060314133633.2814cdf7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314133633.2814cdf7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 01:36:33PM -0800, Andrew Morton wrote:
> gee, that's a lot of exports.  I don't know whether all of these would be
> considered stable over the long-term?

No, their not.  And until systemtap people actually cooperate with us
and put their library functionality do to thing like variable lookups
based on dward/unwinder info into that tree we shouldn't help them at all.

