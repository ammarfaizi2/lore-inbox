Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVJYBmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVJYBmi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 21:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbVJYBmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 21:42:38 -0400
Received: from mx01.cybersurf.com ([209.197.145.104]:6868 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S1751324AbVJYBmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 21:42:37 -0400
Subject: Re: [patch 2.6.13 0/5] normalize calculations of rx_dropped
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Ben Greear <greearb@candelatech.com>
Cc: "John W. Linville" <linville@tuxdriver.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <435D8717.9000107@candelatech.com>
References: <09122005104858.332@bilbo.tuxdriver.com>
	 <4325CEAB.2050600@pobox.com> <20050912191419.GB19644@tuxdriver.com>
	 <435D53AE.3020401@candelatech.com> <20051024215751.GH28212@tuxdriver.com>
	 <435D8717.9000107@candelatech.com>
Content-Type: text/plain
Organization: unknown
Date: Mon, 24 Oct 2005 21:42:18 -0400
Message-Id: <1130204538.6187.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-24-10 at 18:15 -0700, Ben Greear wrote:
[..]
> That way, the rx-errors counter can be used for folks who just care
> that the packet was not correctly received, and those that care about
> the details can look at the individual errors (and sum them up in various
> configurations due to personal taste, etc.)
> 

Look at http://www.faqs.org/rfcs/rfc2665.html
for a more finer breakdown.

rx/tx_errors may be further broken down.

cheers,
jamal

