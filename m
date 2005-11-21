Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbVKUVgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbVKUVgX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbVKUVgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:36:23 -0500
Received: from minus.inr.ac.ru ([194.67.69.97]:12998 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750931AbVKUVgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:36:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=YYGh6g+cJfv0uxVYwclDvu6/hvMQIMOohLBhlUs/Ss0wHSBZ6AZTDIK3+qhxL6gR7jgcRDMb3jp6ebdIIz8XQLY2vvwTyOUYxct/vvmSxccpa/jLbrKSMtjpEVmK8L8yFzwMPSsd2Mqjl0yfZVaFD+oP3SII5bEKzUCvRYgiEyo=;
Date: Tue, 22 Nov 2005 00:35:49 +0300
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Christopher Friesen <cfriesen@nortel.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: netlink nlmsg_pid supposed to be pid or tid?
Message-ID: <20051121213549.GA28187@ms2.inr.ac.ru>
References: <438220C3.4040602@nortel.com> <E1EeIcx-0006i3-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EeIcx-0006i3-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I tend to agree with you here that tgid makes more sense.

I agree, apparently netlink_autobind was missed when sed'ing pid->tgid.
Of course, it does not matter, but tgid is nicer choice from user's viewpoint.

Alexey
