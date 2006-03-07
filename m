Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbWCGCNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWCGCNw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932610AbWCGCNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:13:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:7040 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932608AbWCGCNu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:13:50 -0500
Date: Mon, 6 Mar 2006 18:18:07 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>
Subject: Re: [RFC][PATCH 1/6] prepare sysctls for containers
Message-ID: <20060307021807.GH27645@sorel.sous-sol.org>
References: <20060306235248.20842700@localhost.localdomain> <20060306235249.880CB28A@localhost.localdomain> <20060307010139.GF27645@sorel.sous-sol.org> <1141697051.9274.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141697051.9274.58.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Dave Hansen (haveblue@us.ibm.com) wrote:
> Yup, that is missing for now.  We couldn't agree on quite which
> implementation we want for basic containers/vservers/vpses.  So, for
> now, making it useful is left as an exercise to the reader. :)

;-)

> BTW, the current code _is_ potentially context sensitive because
> "current" provides much of the context that we will ever need.

Right.  More a question of sysadmin lowering limits which aren't seen
in any context but sysadmin context.  But from your comments above and
in other mail, I understand the requirements aren't fully baked yet.

thanks,
-chris
