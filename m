Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270461AbTGNAHk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 20:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270462AbTGNAHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 20:07:40 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:19346 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S270464AbTGNAHc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 20:07:32 -0400
Date: Sun, 13 Jul 2003 17:22:00 -0700
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Larry McVoy <lm@bitmover.com>, roland@topspin.com, alan@storlinksemi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-ID: <20030714002200.GA24697@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"David S. Miller" <davem@redhat.com>, Larry McVoy <lm@bitmover.com>,
	roland@topspin.com, alan@storlinksemi.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
	netdev@oss.sgi.com
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com> <20030713004818.4f1895be.davem@redhat.com> <52u19qwg53.fsf@topspin.com> <20030713160200.571716cf.davem@redhat.com> <20030713233503.GA31793@work.bitmover.com> <20030713164003.21839eb4.davem@redhat.com> <20030713235424.GB31793@work.bitmover.com> <20030713165323.3fc2601f.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030713165323.3fc2601f.davem@redhat.com>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 13, 2003 at 04:53:23PM -0700, David S. Miller wrote:
> On Sun, 13 Jul 2003 16:54:24 -0700
> Larry McVoy <lm@bitmover.com> wrote:
> 
> > Every time I tried to push the page flip idea or offloading or any of
> > that crap, Andy Bechtolsheim would tell "the CPUs will get faster faster
> > than you can make that work".  He was right.
> 
> I really don't see why receive is so much of a big deal
> compared to send, and we do a send side version of this
> stuff already with zero problems.

Hey, maybe it isn't, but could you please quantify the cost of the VM 
operations?  How hard is that?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
