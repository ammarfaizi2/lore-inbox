Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWEaVFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWEaVFF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 17:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWEaVFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 17:05:05 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33248 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S964993AbWEaVFD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 17:05:03 -0400
Date: Wed, 31 May 2006 16:47:23 -0400
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
Message-ID: <20060531204723.GE21860@rhun.ibm.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop> <20060531182652.3308.1244.stgit@stevo-desktop> <20060531114059.704ef1f1@localhost.localdomain> <ada3beqyp39.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada3beqyp39.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 12:24:42PM -0700, Roland Dreier wrote:
> > > +	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);
> 
> > Please put paren's after sizeof, it is not required by C but it
> > is easier to read.
> 
> I disagree -- I hate seeing sizeof look like a function call.

CodingStyle isn't explicit on this issue, but it does use parens in an
example demonstrating how to pass the size of a struct to kmalloc.

(grepping and comparing numbers for both usages in the code left as an
exercise to the bored).

Cheers,
Muli
