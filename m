Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVGJB2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVGJB2Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 21:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVGJB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 21:28:25 -0400
Received: from animx.eu.org ([216.98.75.249]:58565 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S261810AbVGJB2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 21:28:24 -0400
Date: Sat, 9 Jul 2005 21:45:59 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Eric Sandall <eric@sandall.us>
Cc: Jeremy Nickurak <atrus@lkml.spam.rifetech.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-ID: <20050710014559.GA15844@animx.eu.org>
Mail-Followup-To: Eric Sandall <eric@sandall.us>,
	Jeremy Nickurak <atrus@lkml.spam.rifetech.com>,
	linux-kernel@vger.kernel.org
References: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net> <1120836958.16935.1.camel@localhost> <20050708224106.GA10649@animx.eu.org> <Pine.LNX.4.63.0507091559030.486@cerberus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507091559030.486@cerberus>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandall wrote:
> >Of course, now this begs the question: Is it possible to create a large 
> >file
> >w/o actually writing that much to the device (ie uninitialized).  There's
> >absolutely no reason that a swap file needs to be fully initialized, only
> >part which mkswap does.  Of course, I would expect that ONLY root beable to
> >do this. (or capsysadmin or whatever the caps are)
> 
> That would make the swap file fragment as it's used, instead of
> allocating one big file (the entire file) at once (and hopefully get
> one contiguous chunk of the disk).

You misunderstood entirely what I said.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
