Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262320AbVAJQcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262320AbVAJQcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 11:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVAJQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 11:32:46 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:52276 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S262320AbVAJQcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 11:32:36 -0500
Date: Mon, 10 Jan 2005 17:33:56 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Anton Blanchard <anton@samba.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: kallsyms gate page patch breaks module lookups
Message-ID: <20050110163356.GB15726@mars.ravnborg.org>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	Anton Blanchard <anton@samba.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20050110111337.GM14239@krispykreme.ozlabs.ibm.com> <15034.1105364669@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15034.1105364669@ocs3.ocs.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 12:44:29AM +1100, Keith Owens wrote:
> On Mon, 10 Jan 2005 22:13:37 +1100, 
> Anton Blanchard <anton@samba.org> wrote:
> >Your recent patch looks to break module kallsyms lookups....
> >It looks like if CONFIG_KALLSYMS_ALL is set then we never look up module
> >addresses.
> 
> Separate lookups for kernel and modules when CONFIG_KALLSYMS_ALL=y.

Applied

	Sam
