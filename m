Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVAGAsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVAGAsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVAGA2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:28:55 -0500
Received: from [213.146.154.40] ([213.146.154.40]:27057 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261229AbVAGA01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:26:27 -0500
Date: Fri, 7 Jan 2005 00:26:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107002624.GA29006@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
	wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
	greghk@us.ibm.com, torvalds@osdl.org
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106162928.650e9d71.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 04:29:28PM -0800, Andrew Morton wrote:
> Fine.  Completely agree.  Sometimes people do need to be forced to make
> such changes - I don't think anyone would disagree with that.
> 
> What's under discussion here is "how to do it".  Do we just remove things
> when we notice them, or do we give (say) 12 months notice?

Remove when we notice with a short (measured in weeks) period where that
removal happens only in -mm.  It's a price people have to pay for not
submitting their code upstream.
