Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbULHTbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbULHTbm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULHTbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:31:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:61647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261328AbULHTbc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:31:32 -0500
Date: Wed, 8 Dec 2004 11:30:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Patrick McHardy <kaber@trash.net>
Cc: hadi@cyberus.ca, "David S. Miller" <davem@davemloft.net>, tgraf@suug.ch,
       akpm@osdl.org, tomc@compaqnet.fr, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
Message-Id: <20041208113014.3dcad5f5@dxpl.pdx.osdl.net>
In-Reply-To: <41B73263.4040706@trash.net>
References: <1102380430.6103.6.camel@buffy>
	<20041206224441.628e7885.akpm@osdl.org>
	<1102422544.1088.98.camel@jzny.localdomain>
	<41B5E188.5050800@trash.net>
	<20041207170748.GF1371@postel.suug.ch>
	<41B5E722.2080600@trash.net>
	<20041207213053.6bb602c1.davem@davemloft.net>
	<1102507470.1051.27.camel@jzny.localdomain>
	<41B73263.4040706@trash.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if this is related but something broke netem after 2.6.10-rc2
Now a simple request to delay 10ms ends up taking 1000ms.

Still narrowing down the changeset, but it isn't a change in netem
or tc utils since these didn't change.
