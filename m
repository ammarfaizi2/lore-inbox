Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbUCIGBB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 01:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUCIGBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 01:01:00 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:15503 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261573AbUCIGA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 01:00:58 -0500
Date: Tue, 9 Mar 2004 07:01:27 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, thomas.schlichter@web.de,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-ID: <20040309070127.GA2958@zaniah>
References: <200403090014.03282.thomas.schlichter@web.de> <jeptbmlxb2.fsf@sykes.suse.de> <20040308162947.4d0b831a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308162947.4d0b831a.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2004 at 16:29 +0000, Andrew Morton wrote:

> Andreas Schwab <schwab@suse.de> wrote:
> >
> > Thomas Schlichter <thomas.schlichter@web.de> writes:
> > 
> > > P.S.: Wouldn't it be nice if gcc complained about these mistakes?
> > 
> > Among these 18 cases are 13 false positives. :-)
> 
> Rename Thomas's script to crappy-code-detector.sh and its hit rate goes to
> 100% ;)
> 

Was this patch so crappy ? http://tinyurl.com/2jbe4 , 

-				check_nmi_watchdog();
+				if (check_nmi_watchdog() < 0);
+					timer_ack = !cpu_has_tsc


regards,
Phil

