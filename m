Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbVHROHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbVHROHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 10:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVHROHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 10:07:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:46301 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932232AbVHROHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 10:07:16 -0400
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the
	difference	between /dev/kmem and /dev/mem)
From: Arjan van de Ven <arjan@infradead.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <130440000.1124031022@[10.10.2.4]>
References: <1123796188.17269.127.camel@localhost.localdomain>
	 <1123809302.17269.139.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
	 <1123951810.3187.20.camel@laptopd505.fenrus.org>
	 <130440000.1124031022@[10.10.2.4]>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 16:07:05 +0200
Message-Id: <1124374025.3220.14.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Whilst there's no normal legitimite usage for it, it is useful for debugging.
> One thing I often do is create a circular log buffer, then fish it back 
> out by mmaping /dev/mem or /dev/kmem, and going by system.map offsets.
> No, nobody could claim it was clean or elegant, but it *is* useful.

relayfs.



