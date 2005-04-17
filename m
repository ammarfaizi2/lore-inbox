Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVDQVlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVDQVlA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 17:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVDQVlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 17:41:00 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:18442 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261489AbVDQVk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 17:40:56 -0400
Date: Mon, 18 Apr 2005 07:37:33 +1000
To: Patrick McHardy <kaber@trash.net>
Cc: Thomas Graf <tgraf@suug.ch>, Steven Rostedt <rostedt@goodmis.org>,
       hadi@cyberus.ca, netdev <netdev@oss.sgi.com>,
       Tarhon-Onu Victor <mituc@iasi.rdsnet.ro>, kuznet@ms2.inr.ac.ru,
       devik@cdi.cz, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: ACPI/HT or Packet Scheduler BUG?
Message-ID: <20050417213733.GB22372@gondor.apana.org.au>
References: <Pine.LNX.4.61.0504121526550.4822@blackblue.iasi.rdsnet.ro> <Pine.LNX.4.61.0504141840420.13546@blackblue.iasi.rdsnet.ro> <1113601029.4294.80.camel@localhost.localdomain> <1113601446.17859.36.camel@localhost.localdomain> <1113602052.4294.89.camel@localhost.localdomain> <20050415225422.GF4114@postel.suug.ch> <20050416014906.GA3291@gondor.apana.org.au> <20050416110639.GI4114@postel.suug.ch> <20050416111236.GA31550@gondor.apana.org.au> <4262A0E8.9020905@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4262A0E8.9020905@trash.net>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 17, 2005 at 07:46:16PM +0200, Patrick McHardy wrote:
> 
> HTB also needs to be fixed. Destruction is usually defered by the
> refcnt until ->put(), htb_put() doesn't lock the tree. Same for
> HFSC and CBQ.

Yes you're absolutely right.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
