Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWCMQa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWCMQa6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 11:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWCMQa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 11:30:58 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:20753 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751504AbWCMQa5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 11:30:57 -0500
Date: Mon, 13 Mar 2006 17:30:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Petr Vandrovec <petr@vandrovec.name>, linux-kernel@vger.kernel.org,
       sam@ravenborg.org, kai@germaschewski.name
Subject: Re: [PATCH] Do not rebuild full kernel tree again and again...
Message-ID: <20060313163041.GA29719@mars.ravnborg.org>
References: <20060312172511.GA17936@vana.vc.cvut.cz> <20060312174250.GA1470@mars.ravnborg.org> <44150CD7.604@yahoo.com.au> <20060313091254.GA28231@mars.ravnborg.org> <44154DAC.6050006@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44154DAC.6050006@yahoo.com.au>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 09:47:08PM +1100, Nick Piggin wrote:
 >>I'm seeing this behaviour too in -rc6 and it is a bad regression
> >>for a developer. I assume there will be some workaround?
> >
> >I assume debian soon will update make to current version from CVS that
> >has this behaviour removed.
> >
> 
> So long as it just requires a tools update then that's fine for me.
I should note here that it was agreed with Paul that upcoming make
relase will not have this change, but next release will have it.
So 2.6.17 kbuild will take care of being forward compatible in this
matter.

	Sam
