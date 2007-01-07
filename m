Return-Path: <linux-kernel-owner+w=401wt.eu-S932368AbXAGCy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbXAGCy2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbXAGCy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:54:28 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:28326 "HELO
	smtp106.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932368AbXAGCy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:54:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=fbNlOtRlvjeMHBwCrcsHlet05BYKjPqZJN16iJaQRUlSH+NI6Y061LjQJFjHrU5icJVRyo17jszpCdPaneJ66+FVBhebro8zu/0Jq6tKznvNu8ix+CPf2Jv6zsx4OVJ3Aq79xmehWB7QYajS0Dt2wGz3ebYgsbI7LzPd8amM8uU=  ;
X-YMail-OSG: 18jt6dwVM1kpoC9I8cF2.IiB1UUSvrtDYewYy79qV0KLHVCkH0c2QUnCbkA9dm5wqKmZfUPb3POj.ZcNheWvM6QFanjn39Jj7PhbFFtPbGkP9gG2SWLpkSsari8X3RWt94IdxR1HQtHd_WRsyBNSuyM5MxL03htNY_x.xDTlltzH4YEEIS8VpZ7bojHA
Date: Sat, 06 Jan 2007 18:54:24 -0800
From: David Brownell <david-b@pacbell.net>
To: hugh@veritas.com
Subject: Re: RTC subsystem and fractions of seconds
Cc: phdm@macqel.be, mpm@selenic.com, linux-kernel@vger.kernel.org
References: <200701051949.00662.david-b@pacbell.net>
 <20070106232633.GA8535@ingate.macqel.be>
 <200701061552.43654.david-b@pacbell.net>
 <Pine.LNX.4.64.0701070108001.1428@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701070108001.1428@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20070107025425.0A7C21FAC07@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hmm ... "looping" fights against "quickly"; as would "wait for next
> > update IRQ" (on RTCs that support that).  But it would improve precision,
> > at least in the sense of having the system clock and that RTC spending
> > less time with the lowest "seconds" digit disagreeing.
> > 
> > This is something you could write a patch for, n'est-ce pas?
>
> If you're thinking of going that way,

Philippe seemed to be ...


>	it'd be courteous to CC Matt,
> who devoted some effort to removing just that loop in 2.6.17 ;)

Hmm ... "git whatchanged drivers/rtc/hctosys.c" shows no such change.
So I can't find any record of such a change or its rationale.


- dave


