Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbTJMQPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTJMQPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:15:30 -0400
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:12765
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S261871AbTJMQP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:15:28 -0400
Date: Mon, 13 Oct 2003 09:15:22 -0700
To: Jari Tenhunen <jait@ee.oulu.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5/2.6 PCMCIA Issues
Message-ID: <20031013161522.GA9362@nasledov.com>
References: <20031013161010.GH1623@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013161010.GH1623@ee.oulu.fi>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I think I know what you're talking about. My laptop won't suspend either if
there are PCMCIA cards in it; once I take out the offending PCMCIA cards and
try to suspend again, it'll suspend properly. I think this is a bug as this
kind of thing never happened in 2.4.. I'm Cc'ing this to lkml, so maybe
somebody will take a look at it...

On Mon, Oct 13, 2003 at 07:10:10PM +0300, Jari Tenhunen wrote:
> Hi,
> 
> I found your old post on lkml. I'm having exactly same kind of problems
> with my laptop (Thinkpad T20). 2.6-series up to 2.6.0-test6 won't
> suspend and it seems that the problem is PCMCIA (no errors, screen
> blanksi, hd spins down but won't suspend). After some testing 
> I found out that after unloading the yenta_socket module everything works.
> 
> Have you seen any patches for this or have you managed to contact the
> developer(s)?

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
