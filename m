Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268700AbTGIXco (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268691AbTGIXcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:32:43 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32434
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268700AbTGIXcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:32:24 -0400
Subject: Re: ->direct_IO API change in current 2.4 BK
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Andreas Dilger <adilger@clusterfs.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Christoph Hellwig <hch@infradead.org>, marcelo@connectiva.com.br,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55L.0307091611140.29759@freak.distro.conectiva>
References: <20030709133109.A23587@infradead.org>
	 <200307091954.12895.m.c.p@wolk-project.de>
	 <Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	 <200307092022.35295.m.c.p@wolk-project.de>
	 <Pine.LNX.4.55L.0307091611140.29759@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057794223.7137.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Jul 2003 00:43:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-09 at 20:13, Marcelo Tosatti wrote:
> I applied it because, in my ignorance, I did not noticed it would break
> the stable API.
> 
> I applied it because I wanted comments useful from people (Like hch and
> others did).

I'm not sure I see what the fuss is about a slight API change that is
safe since it spews warnings/breaks existing code that isnt fixed. At
least one vendor kernel also has the changed API anyway

