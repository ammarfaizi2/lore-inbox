Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSCUR2q>; Thu, 21 Mar 2002 12:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSCUR0j>; Thu, 21 Mar 2002 12:26:39 -0500
Received: from air-2.osdl.org ([65.201.151.6]:13696 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S312398AbSCUR0N>;
	Thu, 21 Mar 2002 12:26:13 -0500
Date: Thu, 21 Mar 2002 09:25:27 -0800
From: Bob Miller <rem@osdl.org>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.7: acct.c oops
Message-ID: <20020321092526.A11399@doc.pdx.osdl.net>
In-Reply-To: <m16o4pO-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 09:50:10AM -0600, Bob_Tracy wrote:
> I might have missed this one.  After all, this is a pretty low-traffic
> list :-).
> 
> Running "accton" (with or without arguments) consistently generates
> an oops at linux/kernel/acct.c:169
> 	BUG_ON(!spin_is_locked(&acct_globals.lock));
> 
> I first saw this when shutting down my machine.  The shutdown scripts
> run "accton" without any arguments to terminate accounting, regardless
> of whether it's running.
> 
> 2.5.7 kernel on a Dell laptop running a Mandrake distribution.
> 
> -- 
> -----------------------------------------------------------------------
> Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
> rct@frus.com
> -----------------------------------------------------------------------
Hi Tracy,

Do you have the rest of the of oops message passed through ksymoops?
I'll also try to reproduce here.  TIA.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
