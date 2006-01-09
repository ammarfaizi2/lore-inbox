Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWAIQqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWAIQqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 11:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWAIQqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 11:46:13 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53640 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751275AbWAIQqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 11:46:12 -0500
Date: Mon, 9 Jan 2006 16:46:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109164611.GA1382@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20060109164214.GA10367@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109164214.GA10367@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 05:42:14PM +0100, Sam Ravnborg wrote:
> Hi hch.
> 
> Any specific reason why xfs uses a indirection for the Makefile?
> It is planned to drop export of VERSION, PATCHLEVEL etc. from
> main makefile and it is OK except for xfs due to the funny
> Makefile indirection.
> 
> I suggest:
> git mv fs/xfs/Makefile-linux-2.6 fs/xfs/Makefile

I'd be all for it, but the SGI people like this layout to keep a common
fs/xfs for both 2.4 and 2.6 (with linux-2.4 and linux-2.6 subdirs respectively)

p.s. and no, I'm not official xfs maintainer and never have been, so cc set
to linux-xfs were all interested parties hang around.
