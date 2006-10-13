Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751637AbWJMNCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWJMNCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 09:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbWJMNCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 09:02:04 -0400
Received: from poczta.o2.pl ([193.17.41.142]:4755 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751637AbWJMNCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 09:02:01 -0400
Date: Fri, 13 Oct 2006 15:06:48 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: David Johnson <dj@david-web.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hardware bug or kernel bug?
Message-ID: <20061013130648.GC1690@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	David Johnson <dj@david-web.co.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061013085605.GA1690@ff.dom.local> <200610131020.48232.dj@david-web.co.uk> <20061013105807.GB1690@ff.dom.local> <200610131256.54546.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610131256.54546.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 12:56:53PM +0100, David Johnson wrote:
> On Friday 13 October 2006 11:58, Jarek Poplawski wrote:
> >
> > PS: I hope you tested it also under internal stress (heavy
> > copying plus computing).
> 
> Yes, I did. No individual factor triggers the bug (high CPU load, lots of disk 
> activity, high network load, etc.) nor does any other combination of factors 
> other than what I mentioned before (high network load, some disk activity, 
> some CPU load).
> 
> Both scp and rsync trigger it reliably, but FTP does not trigger it at all. So 
> CPU load (which scp and rsync generates but FTP does not) must be a key part 
> of the equation...

Probably - but only with networking. So I'd try with this debugging
like in my first reply plus maybe 2.6.19-rc1 (e1000 - btw. I hope
this other tested card was different model - and locking improved)
and resend conclusions to netdev@vger.kernel.org.

Cheers,

Jarek P.
