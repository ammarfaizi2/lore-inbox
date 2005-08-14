Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVHNMNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVHNMNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 08:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVHNMNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 08:13:22 -0400
Received: from arizona.isc.ch ([195.141.178.2]:33775 "EHLO alton.isc.ch")
	by vger.kernel.org with ESMTP id S932502AbVHNMNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 08:13:21 -0400
Date: Sun, 14 Aug 2005 14:12:55 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Grant Coady <Grant.Coady@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
Message-ID: <20050814121255.GA2695@k3.hellgate.ch>
References: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
X-Operating-System: Linux 2.6.13-rc3 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -31,7 +31,7 @@
>  #define APC_BPORT_REG  0x30
> 
>  #define APC_REGMASK            0x01
> -define APC_BPMASK              0x03
> +#define APC_BPMASK             0x03

Color me skeptical. I've seen some weird bit flips and data corruption;
"paramters" to "paramEters" I could buy. But data corruption that
_inserts_ a hash mark a the beginning of a line of a header file? What
are the odds?

> Today disabled onboard via-rhine and used Intel pro/100 + e100 driver, 
> several source trees unpacked identically, running 2.6.12.4 or 2.4.31-hf3

While that seems to point to the Rhine as the possible cause, I can't
see how any driver could possibly be involved in this.

Roger

