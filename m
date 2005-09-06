Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbVIFHdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbVIFHdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbVIFHdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 03:33:17 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:31614 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932437AbVIFHdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 03:33:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=rB8yZc23EutiZfOALGX/WxcNt48Z2kdgOInD+JRxLHCb1eSMnTZe+p5SUtUIW+8Q46HRdplwVA57Ri1QE/EceoFgQ/Yar6i96lTZ9niHOZ08xijV86SyjEb1MRICYqo8zlqm6PQvdnz1pti9Pf3cflT5yGI1uNXqBXrYudA6LuY=  ;
Subject: Re: RFC: i386: kill !4KSTACKS
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andi Kleen <ak@suse.de>
Cc: Denis Vlasenko <vda@ilport.com.ua>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200509060913.59822.ak@suse.de>
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
	 <p73aciqrev0.fsf@verdi.suse.de> <200509060939.28055.vda@ilport.com.ua>
	 <200509060913.59822.ak@suse.de>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 17:32:57 +1000
Message-Id: <1125991977.5138.6.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-06 at 09:13 +0200, Andi Kleen wrote:

> At some point we undoubtedly will need to increase it further, 
> the logical point would be when Linux switches to larger softpage 
> sizes.

Is this really a "when"?

Hugh and wli were both working on this and IIRC neither could
show enough justification to get people interested in it and
get it merged (maybe apart from helping stupidly sized PAE systems
limp along)

And that was even before page size reductions and objrmap came
along, which makes the potential gain even smaller.

Are there still good reasons to have such a thing?

Nick

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
