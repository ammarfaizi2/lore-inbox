Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULHPHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULHPHc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 10:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULHPHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 10:07:10 -0500
Received: from mx03.cybersurf.com ([209.197.145.106]:49051 "EHLO
	mx03.cybersurf.com") by vger.kernel.org with ESMTP id S261235AbULHPGu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 10:06:50 -0500
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Thomas Graf <tgraf@suug.ch>
Cc: Patrick McHardy <kaber@trash.net>, Andrew Morton <akpm@osdl.org>,
       Thomas Cataldo <tomc@compaqnet.fr>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20041208145925.GM1371@postel.suug.ch>
References: <20041206224441.628e7885.akpm@osdl.org>
	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>
	 <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net>
	 <1102480044.1050.9.camel@jzny.localdomain>
	 <1102480913.1049.24.camel@jzny.localdomain> <41B68E5D.2080009@trash.net>
	 <1102509111.1051.54.camel@jzny.localdomain>
	 <20041208143212.GL1371@postel.suug.ch>
	 <20041208145925.GM1371@postel.suug.ch>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102518405.1025.8.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Dec 2004 10:06:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your efforts Thomas.

cheers,
jamal

On Wed, 2004-12-08 at 09:59, Thomas Graf wrote:
> * Thomas Graf <20041208143212.GL1371@postel.suug.ch> 2004-12-08 15:32
> > iproute-2.6.9 was sucessful with all kernels. I couldn't test with the
> > old 2.4.7 iproute2 yet since the syntax has changed and I need to adopt
> > the tests first. I will create better tests and run it on patrick's
> > patch when I get home.
> 
> I've updated the tests and all were successful:
> 
>                                tc-2.6.9-tgr       tc-2.4.7
> 2.6.10-rc2-bk13*                    Y                Y
> 2.6.10-rc2-bk13-no-act*             Y                Y
> 2.4.28-rc1-bk1                      Y                Y
> 
> * including tcf_police patch
> 

