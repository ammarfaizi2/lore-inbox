Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbUA3Xna (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 18:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbUA3Xna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 18:43:30 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:51391 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S264459AbUA3Xn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 18:43:29 -0500
Date: Fri, 30 Jan 2004 15:43:16 -0800
From: Tim Hockin <thockin@sun.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, thomas.schlichter@web.de, thoffman@arnor.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc2-mm2
Message-ID: <20040130234316.GI9155@sun.com>
Reply-To: thockin@sun.com
References: <1075490624.4272.7.camel@laptop.fenrus.com> <20040130114701.18aec4e8.akpm@osdl.org> <20040130201731.GY9155@sun.com> <20040130123301.70009427.akpm@osdl.org> <20040130211256.GZ9155@sun.com> <20040130140024.4b409335.akpm@osdl.org> <20040130223105.GC9155@sun.com> <20040130150819.2425386b.akpm@osdl.org> <20040130232103.GF9155@sun.com> <20040130153149.00bcb210.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130153149.00bcb210.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 03:31:49PM -0800, Andrew Morton wrote:
> > The caller in fs/nfsd/nfsfh.c still needs to check the return value and do
> > something with it, or all this is just dumb.
> 
> We can add that to Neil's todo list ;)

The final patch of this plus my original (which included the
EXPORT_SYMBOL()s) looks good to me.


-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
