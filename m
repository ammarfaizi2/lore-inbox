Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932760AbVITOk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbVITOk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbVITOk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:40:58 -0400
Received: from host-84-9-200-79.bulldogdsl.com ([84.9.200.79]:14215 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S932760AbVITOk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:40:58 -0400
Date: Tue, 20 Sep 2005 15:39:58 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Ben Dooks <ben-linux@fluff.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts - use $OBJDUMP to get correct objdump (cross compile)
Message-ID: <20050920143958.GA3500@home.fluff.org>
References: <20050919210645.GA20669@home.fluff.org> <12002.1127204929@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12002.1127204929@kao2.melbourne.sgi.com>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2005 at 06:28:49PM +1000, Keith Owens wrote:
> On Mon, 19 Sep 2005 22:06:45 +0100, 
> Ben Dooks <ben-linux@fluff.org> wrote:
> >The scripts for `make buildcheck` are executing
> >objdump straight, which is wrong if the system
> >is using `make CROSS_COMPILE=....`. 
> >
> >Change the scripts to use $OBJDUMP passed from
> >the Makefile's environment, so that the correct
> >objdump is used, and the symbols are printed
> >correctly
> 
> Those scripts are meant to work even when they are invoked by hand,
> without OBJDUMP being defined in the environment.  This is the correct
> fix.
> 
> Signed-off-by: Keith Owens <kaos@ocs.com.au>

Ok, that seems to have fixed the problems, thanks.

Acked-by: Ben Dooks <ben-linux@fluff.org>

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
