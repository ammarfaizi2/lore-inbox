Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263657AbUJ3Ifc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263657AbUJ3Ifc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUJ3Ic5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:32:57 -0400
Received: from canuck.infradead.org ([205.233.218.70]:55050 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263649AbUJ3IaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:30:16 -0400
Subject: Re: 2.6.10-rc1-mm2: intelfb/AGP unknown symbols
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>,
       Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <20041030032425.GI6677@stusta.de>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
	 <20041030032425.GI6677@stusta.de>
Content-Type: text/plain
Message-Id: <1099124920.2822.3.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Sat, 30 Oct 2004 10:28:41 +0200
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


> The removal of 3 "unneeded exports" in bk-agpgart.patch conflicts with 
> code adding usage of them in Linus' tree:

that makes me really really curious why the fb driver calls into the backend and not just the agp frontend layer like the rest of the world does...

