Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbULHO7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbULHO7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 09:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbULHO7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 09:59:09 -0500
Received: from eth0-0.arisu.projectdream.org ([194.158.4.191]:23237 "EHLO
	b.mx.projectdream.org") by vger.kernel.org with ESMTP
	id S261232AbULHO7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 09:59:05 -0500
Date: Wed, 8 Dec 2004 15:59:25 +0100
From: Thomas Graf <tgraf@suug.ch>
To: jamal <hadi@cyberus.ca>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
Message-ID: <20041208145925.GM1371@postel.suug.ch>
References: <20041206224441.628e7885.akpm@osdl.org> <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net> <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net> <1102480044.1050.9.camel@jzny.localdomain> <1102480913.1049.24.camel@jzny.localdomain> <41B68E5D.2080009@trash.net> <1102509111.1051.54.camel@jzny.localdomain> <20041208143212.GL1371@postel.suug.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041208143212.GL1371@postel.suug.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Graf <20041208143212.GL1371@postel.suug.ch> 2004-12-08 15:32
> iproute-2.6.9 was sucessful with all kernels. I couldn't test with the
> old 2.4.7 iproute2 yet since the syntax has changed and I need to adopt
> the tests first. I will create better tests and run it on patrick's
> patch when I get home.

I've updated the tests and all were successful:

                               tc-2.6.9-tgr       tc-2.4.7
2.6.10-rc2-bk13*                    Y                Y
2.6.10-rc2-bk13-no-act*             Y                Y
2.4.28-rc1-bk1                      Y                Y

* including tcf_police patch
