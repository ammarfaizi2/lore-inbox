Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964862AbWEaHte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWEaHte (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 03:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEaHte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 03:49:34 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11489
	"EHLO sunset.sfo1.dsl.speakeasy.net") by vger.kernel.org with ESMTP
	id S964851AbWEaHtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 03:49:33 -0400
Date: Wed, 31 May 2006 00:49:53 -0700 (PDT)
Message-Id: <20060531.004953.91760903.davem@davemloft.net>
To: bidulock@openss7.org
Cc: draghuram@rocketmail.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Question about tcp hash function tcp_hashfn()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060531014540.A1319@openss7.org>
References: <20060530235525.A30563@openss7.org>
	<20060531.001027.60486156.davem@davemloft.net>
	<20060531014540.A1319@openss7.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Brian F. G. Bidulock" <bidulock@openss7.org>
Date: Wed, 31 May 2006 01:45:40 -0600

> It might sound like I'm complaining, but I'm not.  The
> function works for me.  But from a purist point of view,
> the hash function is not as efficient as it could be and
> there is room for improvement.

For sure and there are plans afoot to move over to
dynamic table sizing and the Jenkins hash function.
