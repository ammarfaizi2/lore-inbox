Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264497AbUDUKHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264497AbUDUKHm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 06:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUDUKHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 06:07:42 -0400
Received: from users.linvision.com ([62.58.92.114]:15340 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264497AbUDUKHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 06:07:39 -0400
Date: Wed, 21 Apr 2004 12:07:38 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Miles Bader <miles@gnu.org>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, Jan De Luyck <lkml@kcore.org>,
       linux-kernel@vger.kernel.org, postmaster@vger.kernel.org
Subject: Re: vger.kernel.org is listed by spamcop
Message-ID: <20040421100738.GC4270@harddisk-recovery.com>
References: <200404210722.32253.lkml@kcore.org> <20040421084434.GL1749@mea-ext.zmailer.org> <buoad15hfp2.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <buoad15hfp2.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 05:56:41PM +0900, Miles Bader wrote:
> Matti Aarnio <matti.aarnio@zmailer.org> writes:
> > The only way to handle this is to have smarter people, who are always
> > vigilant enough to look deeply into the message headers and do realize
> > that some spam has leaked thru VGER's lists.
> 
> I'm confused -- the spamcopy info page you listed implies that hosts are
> listed if they are an _open relay_, which is a completely different
> thing from `spam leaking though VGER's lists.'

Vger is not an open relay:

% telnet vger.kernel.org smtp
Connected to vger.kernel.org.
Escape character is '^]'.
220 vger.kernel.org ZMailer Server 2.99.57-pre1 #11 ESMTP ready at Wed, 21 Apr 2004 05:56:30 -0400
EHLO harddisk-recovery.com
250-vger.kernel.org expected "EHLO xxx.xxx.xxx"
250-SIZE 0
250-8BITMIME
250-PIPELINING
250-CHUNKING
250-ENHANCEDSTATUSCODES
250-DSN
250-X-RCPTLIMIT 10000
250-ETRN
250 HELP
MAIL FROM: <>
250 2.0.0 Ok (sourcechannel 'error' accepted) Ok
RCPT TO: <erik@harddisk-recovery.com>
550 5.7.1 Your IP address [xx.xx.xx.xx] is not allowed to relay to email address <erik@harddisk-recovery.com> via our server; MX rule

Spamcop is wrong. Some spammer targeted one of the lists on vger. That
doesn't make vger an open relay.

> If VGER actually is an open relay, that's very bad, but presumably
> something easily solved by the machine's maintainers.  Some spam getting
> through to VGER list recipients, on the other hand, is just annoying
> (and certainly shouldn't be the cause of any blacklisting).
> 
> The spamcop report page seems to say that the listings are due to user
> reports; could the real problem be clueless users who don't understand
> the difference above?

Yes.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
