Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWCSSh4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWCSSh4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 13:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWCSSh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 13:37:56 -0500
Received: from waste.org ([64.81.244.121]:15071 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751569AbWCSShz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 13:37:55 -0500
Date: Sun, 19 Mar 2006 12:26:48 -0600
From: Matt Mackall <mpm@selenic.com>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>
Subject: Re: + stack-corruption-detector.patch added to -mm tree
Message-ID: <20060319182648.GE25452@waste.org>
References: <200603082041.k28Kf7H1027435@shell0.pdx.osdl.net> <Pine.LNX.4.63.0603082215330.4484@cuia.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0603082215330.4484@cuia.boston.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:16:50PM -0500, Rik van Riel wrote:
> On Wed, 8 Mar 2006, akpm@osdl.org wrote:
> 
> > -			memset(ret, 0, THREAD_SIZE);		\
> > +			memset(ret, 0x55, THREAD_SIZE);		\
> 
> Xen uses 0x55 as a poison pattern too.  I wonder if we should
> change this one (this one's newer ;)) to something else.

I think we should have a central poison.h file.

-- 
Mathematics is the supreme nostalgia of our time.
