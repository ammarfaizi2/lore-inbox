Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWH2KT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWH2KT1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 06:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWH2KT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 06:19:27 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:18049 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S1750839AbWH2KT0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 06:19:26 -0400
From: gerrit@erg.abdn.ac.uk
To: Patrick McHardy <kaber@trash.net>
Subject: Re: [RFC][PATCHv2 2.6.18-rc4-mm3 3/3] net/ipv4:  misc. support files
Date: Tue, 29 Aug 2006 11:18:00 +0100
User-Agent: KMail/1.8.3
Cc: davem@davemloft.net, jmorris@namei.org, alan@lxorguk.ukuu.org.uk,
       kuznet@ms2.inr.ac.ru, pekkas@netcore.fi, kaber@coreworks.de,
       yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200608231150.37895@strip-the-willow> <200608281910.50647@strip-the-willow> <44F335DE.5030307@trash.net>
In-Reply-To: <44F335DE.5030307@trash.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608291118.00972@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Patrick McHardy:
|  gerrit@erg.abdn.ac.uk wrote:
|  > [Net/IPv4]: REVISED Miscellaneous changes which complete the 
|  >             v4 support for UDP-Lite.
|  > 
|  
|  > --- a/include/net/xfrm.h
|  > +++ b/include/net/xfrm.h
|  > @@ -467,6 +467,7 @@ u16 xfrm_flowi_sport(struct flowi *fl)
|  >  	switch(fl->proto) {
|  >  	case IPPROTO_TCP:
|  >  	case IPPROTO_UDP:
|  > +	case IPPROTO_UDPLITE:
|  >  	case IPPROTO_SCTP:
|  >  		port = fl->fl_ip_sport;
|  >  		break;
|  > @@ -492,6 +493,7 @@ u16 xfrm_flowi_dport(struct flowi *fl)
|  >  	switch(fl->proto) {
|  >  	case IPPROTO_TCP:
|  >  	case IPPROTO_UDP:
|  > +	case IPPROTO_UDPLITE:
|  >  	case IPPROTO_SCTP:
|  >  		port = fl->fl_ip_dport;
|  >  		break;

Many thanks for the helpful pointers - I will make sure that the changes
are in the next version. I will be waiting a little while for further comments
before the update.

- Gerrit
