Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTFHLff (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbTFHLff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 07:35:35 -0400
Received: from mail.ithnet.com ([217.64.64.8]:38162 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261568AbTFHLfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 07:35:34 -0400
Date: Sun, 8 Jun 2003 13:49:01 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030608134901.363ebe42.skraw@ithnet.com>
In-Reply-To: <20030608131901.7cadf9ea.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<2804790000.1052441142@aslan.scsiguy.com>
	<20030509120648.1e0af0c8.skraw@ithnet.com>
	<20030509120659.GA15754@alpha.home.local>
	<20030509150207.3ff9cd64.skraw@ithnet.com>
	<20030605181423.GA17277@alpha.home.local>
	<20030608131901.7cadf9ea.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello author,

shoot me for the last comment regarding __kmem_cache_alloc (which means: forget
it).
Still you have significant source code duplication between "#define
kmem_cache_alloc_one" and "void* kmem_cache_alloc_batch".
How about an exit-symbol parameter?

Regards,
Stephan

