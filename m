Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263234AbVCMGyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbVCMGyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 01:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263236AbVCMGyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 01:54:13 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:27244 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263234AbVCMGyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 01:54:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Patrick McHardy <kaber@trash.net>
Subject: Re: Last night Linus bk - netfilter busted?
Date: Sun, 13 Mar 2005 01:54:02 -0500
User-Agent: KMail/1.7.2
Cc: Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org
References: <E1D9rZX-0004KE-00@gondolin.me.apana.org.au> <423221FF.8020103@trash.net>
In-Reply-To: <423221FF.8020103@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503130154.03777.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 17:55, Patrick McHardy wrote:
> Herbert Xu wrote:
> > Patrick McHardy <kaber@trash.net> wrote:
> > 
> >>You're right, good catch. IPT_RETURN is interpreted internally by
> >>ip_tables, but since the value changed it isn't recognized by ip_tables
> >>anymore and returned to nf_iterate() as NF_REPEAT. This patch restores
> >>the old value.
> > 
> > 
> > Please fix netfilter_arp while you're at it since it does exactly
> > the same thing.
> 
> New patch attached, thanks.
> 

If this is of any interest, yesterday's pull from Linux plus this patch
seem to be working fine here.

Thank you.

-- 
Dmitry
