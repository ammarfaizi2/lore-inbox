Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbULOKTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbULOKTs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 05:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbULOKTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 05:19:48 -0500
Received: from canuck.infradead.org ([205.233.218.70]:57101 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261165AbULOKTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 05:19:39 -0500
Subject: Re: [PATCH] enable meye even when CONFIG_HIGHMEM64G=y
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041213153843.GD31695@redhat.com>
References: <20041213110753.GB3646@crusoe.alcove-fr>
	 <20041213153843.GD31695@redhat.com>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 11:02:11 +0100
Message-Id: <1103104931.4133.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-13 at 10:38 -0500, Dave Jones wrote:
> On Mon, Dec 13, 2004 at 12:07:54PM +0100, Stelian Pop wrote:
> 
>  > However, this way of doing it also makes meye unavailable on
>  > some kernel configurations. As Arjan said previously, future Fedora
>  > kernels will have HIGHMEM64G activated by default. 
> 
> Not whilst there are boxes out there that won't boot when PAE
> is enabled they won't.

the smp ones might... for HT/dual core machines


