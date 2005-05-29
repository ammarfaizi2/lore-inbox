Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVE2I1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVE2I1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 04:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVE2I1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 04:27:07 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:51864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261283AbVE2I1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 04:27:03 -0400
Date: Sun, 29 May 2005 09:26:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Dave Jones <davej@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, David Airlie <airlied@linux.ie>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
Message-ID: <20050529082651.GA19720@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kyle Moffett <mrmacman_g4@mac.com>, Dave Jones <davej@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@osdl.org>, David Airlie <airlied@linux.ie>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	dri-devel@lists.sourceforge.net
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com> <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 29, 2005 at 12:25:10AM -0400, Kyle Moffett wrote:
> If DRM is built-in, then AGP _must_ be built-in or not included at  
> all, modular
> won't work.  If DRM is modular or not built, then AGP may be built- 
> in, modular,
> or not built at all.
> 
> The "depends on AGP || AGP=n" means that if DRM=y, then AGP=y or  
> AGP=n, and if
> DRM=m or DRM=n, then AGP=y or AGP=m or AGP=n.
> 
> Yes it's unclear and yes it should probably be documented in a  
> comment somewhere.

could be written easier as depends on AGP if AGP

