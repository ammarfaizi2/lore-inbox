Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265591AbTHSJho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269451AbTHSJho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:37:44 -0400
Received: from mail-02.iinet.net.au ([203.59.3.34]:15793 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265591AbTHSJhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:37:43 -0400
Subject: Re: weird pcmcia problem
From: Sven Dowideit <svenud@ozemail.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Narayan Desai <desai@mcs.anl.gov>, linux-kernel@vger.kernel.org
In-Reply-To: <20030819093414.A12052@flint.arm.linux.org.uk>
References: <87u18efpsc.fsf@mcs.anl.gov>
	 <20030819093414.A12052@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1061320339.10855.3.camel@sven>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 20 Aug 2003 05:12:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thank god its not just my t21 :)

this is the same issue that I've had since somewhere between 2.5.70
2.5.75 (i didn't use any of the ones in between)

Russell - sorry for no tbugging you after OLS :) 

sven

On Tue, 2003-08-19 at 18:34, Russell King wrote:
> On Mon, Aug 18, 2003 at 07:34:59PM -0500, Narayan Desai wrote:
> > cs: warning: no high memory space available!
> > cs: unable to map card memory!
> > cs: unable to map card memory!
> 
> Hmm, this looks suspicious.  For some reason, we can't find any memory
> resources to map the CIS, so we can't identify the card type, which
> means we'll probably identify the card as a memory card.

