Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWEaU6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWEaU6E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbWEaU6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:58:04 -0400
Received: from es335.com ([67.65.19.105]:49965 "EHLO mail.es335.com")
	by vger.kernel.org with ESMTP id S964971AbWEaU6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:58:02 -0400
Subject: Re: [PATCH 1/2] iWARP Connection Manager.
From: Steve Wise <swise@opengridcomputing.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <ada3beqyp39.fsf@cisco.com>
References: <20060531182650.3308.81538.stgit@stevo-desktop>
	 <20060531182652.3308.1244.stgit@stevo-desktop>
	 <20060531114059.704ef1f1@localhost.localdomain> <ada3beqyp39.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 31 May 2006 15:58:00 -0500
Message-Id: <1149109080.7469.15.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-31 at 12:24 -0700, Roland Dreier wrote:
> > > +	cm_id_priv = kzalloc(sizeof *cm_id_priv, GFP_KERNEL);
> 
> > Please put paren's after sizeof, it is not required by C but it
> > is easier to read.
> 
> I disagree -- I hate seeing sizeof look like a function call.
> 

For the most part, drivers/infiniband/core uses sizeof without
parentheses.  So I think the correct answer here is to keep the iwcm.c
file in line with the rest of the core.


Steve.



