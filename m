Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWFUD03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWFUD03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbWFUD03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:26:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750729AbWFUD02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:26:28 -0400
Date: Tue, 20 Jun 2006 20:26:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: jeremy@goop.org, linux-kernel@vger.kernel.org,
       Christian.Limpach@cl.cam.ac.uk, chrisw@sous-sol.org
Subject: Re: [PATCH] Implement kasprintf
Message-Id: <20060620202617.f39d7ca6.akpm@osdl.org>
In-Reply-To: <20060621030444.GG20625@skunkworks.cabal.ca>
References: <44988B5C.9080400@goop.org>
	<20060621030444.GG20625@skunkworks.cabal.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 23:04:44 -0400
Kyle McMartin <kyle@parisc-linux.org> wrote:

> On Tue, Jun 20, 2006 at 04:57:16PM -0700, Jeremy Fitzhardinge wrote:
> > +char *kasprintf(gfp_t gfp, const char *fmt, ...)
> > +{
> 
> Why not just asprintf? We don't have ksprintf... 

asprintf() doesn't take a gfp_t arg.

