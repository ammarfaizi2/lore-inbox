Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVDAObi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVDAObi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 09:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVDAObg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 09:31:36 -0500
Received: from main.gmane.org ([80.91.229.2]:59294 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261660AbVDAObe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 09:31:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: connector.c
Date: Fri, 01 Apr 2005 16:29:55 +0200
Organization: {M:U} IT-Consulting
Message-ID: <pan.2005.04.01.14.29.54.632690@smurf.noris.de>
References: <20050331173026.3de81a05.akpm@osdl.org> <20050331204135.30270c78.Tommy.Reynolds@MegaCoder.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4E   G?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,   Tommy Reynolds schrub am Thu, 31 Mar 2005 20:41:35 -0600:

> Uttered Andrew Morton <akpm@osdl.org>, spake thus:
> 
>> > 	if (uskb) {
>> > 		netlink_unicast(dev->nls, uskb, 0, 0);
>> > 	}
>> 
>> Unneeded {}
> 
> However, for maintainability (and best practices) they are essential.

They do add visual clutter, though, so they make the code as-is less
readable.

I don't think it's entirely accidental that Python is so much more
readable. (For me, anyway -- YMMV and all that.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


