Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbVAGW0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVAGW0C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVAGWXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:23:50 -0500
Received: from [213.146.154.40] ([213.146.154.40]:38342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261664AbVAGWTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:19:13 -0500
Date: Fri, 7 Jan 2005 22:19:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, torvalds@osdl.org
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050107221905.GA17567@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, mingo@elte.hu,
	viro@parcelfarce.linux.theplanet.co.uk, paulmck@us.ibm.com,
	arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
	wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
	greghk@us.ibm.com, torvalds@osdl.org
References: <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106234123.GA27869@infradead.org> <20050106162928.650e9d71.akpm@osdl.org> <20050107002624.GA29006@infradead.org> <20050107090014.GA24946@elte.hu> <20050107091542.GA5295@infradead.org> <20050107140034.46aec534.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050107140034.46aec534.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 02:00:34PM -0800, Andrew Morton wrote:
> No, I'd say that unexports are different.  They can clearly break existing
> code and so should only be undertaken with caution, and with lengthy notice
> if possible.

As mentioned before we only unexported symbols were we were pretty clear
that all users of it are indeep utterly broken.  I got about a dozend
replies for this patches, and for more than half of it where the reporter
was either the author or the module was opensource I could help them to
actually fix their code.  In this case the code is far more broken than
the others, but we've even been trying to help them fix their code for
more than a year, but IBM folks have been constanly refusing.

> The cost to us of maintaining those two lines of code for a year is
> basically zero.

But as long as IBM people don't fix their %$^%! they'll continue annoying
us and the Distibutors about adding more and more hacks for it, and other
people will write similarly crappy code using it again and making the
removal even more difficult. 

> > <sarcasm>
> > <osdl-salespitch>
> > Unfortunately you don't have the financial and political powers IBM
> > has, so your opinion doesn't matter as much.  Maybe you should become
> > OSDL member to influence the direction of Linux development.
> > </osdl-salespitch>
> > </sarcasm>
> 
> Christoph, it would be better to constraint yourself to commenting on other
> people's actions rather than entering into premature speculation regarding
> their motivations, especially when that speculation involves accusations of
> corruption.

Hey, you got messages in this thread from half a dozen kernel contributors
here and still stand against all of them and for IBM who's violating our
copyrights that don't allow non-propritary derived works from it which
any user of these deeply-internal modules clearly is.

I don't know nor care nor want to speculate over anyones motives, but the
situation is at least strange enough to deserve a little sarcastic anekdote.

