Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136311AbRDWAPy>; Sun, 22 Apr 2001 20:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136312AbRDWAPn>; Sun, 22 Apr 2001 20:15:43 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:54024 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S136311AbRDWAPa>;
	Sun, 22 Apr 2001 20:15:30 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15075.29623.148296.605673@tango.linuxcare.com.au>
Date: Mon, 23 Apr 2001 10:13:43 +1000 (EST)
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (kernel list)
Subject: Re: [PATCH] CONFIG_PPP_FILTER in -ac12 / -pre6
In-Reply-To: <200104222120.XAA04041@green.mif.pg.gda.pl>
In-Reply-To: <200104222120.XAA04041@green.mif.pg.gda.pl>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz writes:

> CONFIG_PPP_FILTER depends on CONFIG_FILTER (2.4.4-pre6, 2.4.3-ac12)
> [ sk_run_filter(), ...]
> So updated Config.in ...

> -   bool '  PPP filtering' CONFIG_PPP_FILTER
> +   dep_bool '  PPP filtering' CONFIG_PPP_FILTER $CONFIG_FILTER

Yep, definitely a good idea.  Thanks.

Paul.
