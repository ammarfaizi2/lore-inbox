Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263703AbUJ3LhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbUJ3LhA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263706AbUJ3LhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:37:00 -0400
Received: from canuck.infradead.org ([205.233.218.70]:14603 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263703AbUJ3LfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:35:18 -0400
Subject: Re: [Linux-fbdev-devel] Re: 2.6.10-rc1-mm2: intelfb/AGP unknown
	symbols
From: Arjan van de Ven <arjan@infradead.org>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200410301921.34961.adaplas@hotpop.com>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	 <20041030032425.GI6677@stusta.de>
	 <1099124920.2822.3.camel@laptop.fenrus.org>
	 <200410301921.34961.adaplas@hotpop.com>
Content-Type: text/plain
Message-Id: <1099136087.3883.0.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 30 Oct 2004 13:34:47 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> What's wrong with exporting the symbols back again?

if they are the right api to use; nothing. If they aren't (and what you
describe somehow suggests they aren't) it sounds better to make the
frontend usable for the intelfb driver instead...

