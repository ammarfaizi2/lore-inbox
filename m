Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261327AbVAGJRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261327AbVAGJRU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 04:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVAGJRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 04:17:19 -0500
Received: from [213.146.154.40] ([213.146.154.40]:36537 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261327AbVAGJPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 04:15:48 -0500
Date: Fri, 7 Jan 2005 09:15:42 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107091542.GA5295@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
	wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
	greghk@us.ibm.com, torvalds@osdl.org
References: <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107090014.GA24946@elte.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 10:00:14AM +0100, Ingo Molnar wrote:
> so my strong position is that even asking for any 'warning period' for
> changes in VFS internals (including exports/unexports) would be
> extremely rude. It would be rude not only towards the authors and
> maintainers of mainline VFS code, but also towards other external
> trees/drivers who do _not_ ask for any special status and accept the
> deal: "follow internals, notice kernel people if they do bad stuff
> (extremely rare in my case) and fix/redesign stuff if the external tree
> is broken (much more common)".

<sarcasm>
<osdl-salespitch>
Unfortunately you don't have the financial and political powers IBM
has, so your opinion doesn't matter as much.  Maybe you should become
OSDL member to influence the direction of Linux development.
</osdl-salespitch>
</sarcasm>

