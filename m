Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUIVIpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUIVIpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 04:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUIVIpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 04:45:13 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:13466 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S263024AbUIVIpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 04:45:10 -0400
Date: Wed, 22 Sep 2004 10:44:05 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] updated inotify
Message-ID: <20040922084405.GA20842@k3.hellgate.ch>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Robert Love <rml@novell.com>, ttb@tentacle.dhs.org,
	linux-kernel@vger.kernel.org
References: <1095800893.5090.16.camel@betsy.boston.ximian.com> <20040921235449.GO2482@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040921235449.GO2482@conectiva.com.br>
X-Operating-System: Linux 2.6.9-rc2-bk1-nproc on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Sep 2004 20:54:49 -0300, Arnaldo Carvalho de Melo wrote:
> > +
> > +	if (!kevent) {
> 
> kevent == NULL (I like !pointer, but hey, Linus says NULL is cute, so...)

No, such a rule would be brain-dead. You can safely keep using !pointer.

Roger
