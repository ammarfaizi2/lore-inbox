Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbVAGIMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbVAGIMd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 03:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVAGIMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 03:12:32 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48824 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261307AbVAGIMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 03:12:31 -0500
Date: Fri, 7 Jan 2005 08:12:26 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107081226.GA4511@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
	wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
	greghk@us.ibm.com, torvalds@osdl.org
References: <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <1105055333.17166.304.camel@localhost.localdomain> <20050106191735.0421cdca.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106191735.0421cdca.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 07:17:35PM -0800, Andrew Morton wrote:
> The symbols were exported to non-gpl modules.  People used them.  Maybe
> they shouldn't have.  Maybe they were asked not to do so, and maybe or
> maybe not they noticed.  Certainly we shouldn't have exported these things
> in the first place.

just because it was exported it doesn't mean it ever was legal.

