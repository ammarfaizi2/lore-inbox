Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbULHTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbULHTtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 14:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbULHTtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 14:49:52 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:53402 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S261337AbULHTtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 14:49:50 -0500
Subject: Re: Hard freeze with 2.6.10-rc3 and QoS, worked fine with 2.6.9
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Patrick McHardy <kaber@trash.net>, "David S. Miller" <davem@davemloft.net>,
       tgraf@suug.ch, akpm@osdl.org, tomc@compaqnet.fr,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <20041208113014.3dcad5f5@dxpl.pdx.osdl.net>
References: <1102380430.6103.6.camel@buffy>
	 <20041206224441.628e7885.akpm@osdl.org>
	 <1102422544.1088.98.camel@jzny.localdomain> <41B5E188.5050800@trash.net>
	 <20041207170748.GF1371@postel.suug.ch> <41B5E722.2080600@trash.net>
	 <20041207213053.6bb602c1.davem@davemloft.net>
	 <1102507470.1051.27.camel@jzny.localdomain> <41B73263.4040706@trash.net>
	 <20041208113014.3dcad5f5@dxpl.pdx.osdl.net>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1102535388.1022.118.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 08 Dec 2004 14:49:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,
Can we incoporate the tests from Thomas as part of iproute2?
I have about 20 or so i could add in. Maybe you could add some
for netem as well.

cheers,
jamal

On Wed, 2004-12-08 at 14:30, Stephen Hemminger wrote:
> I don't know if this is related but something broke netem after 2.6.10-rc2
> Now a simple request to delay 10ms ends up taking 1000ms.
> 
> Still narrowing down the changeset, but it isn't a change in netem
> or tc utils since these didn't change.
> 

