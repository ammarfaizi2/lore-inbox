Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWF1RtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWF1RtH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 13:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWF1RtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 13:49:06 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:61362 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751510AbWF1RtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 13:49:05 -0400
Date: Wed, 28 Jun 2006 10:49:41 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] kernel/rcutorture.c: make code static
Message-ID: <20060628174941.GF1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060627015211.ce480da6.akpm@osdl.org> <20060628165445.GQ13915@stusta.de> <20060628171309.GE1293@us.ibm.com> <20060628171751.GK13915@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628171751.GK13915@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 07:17:51PM +0200, Adrian Bunk wrote:
> On Wed, Jun 28, 2006 at 10:13:09AM -0700, Paul E. McKenney wrote:
> > On Wed, Jun 28, 2006 at 06:54:45PM +0200, Adrian Bunk wrote:
> > > This patch makes needlessly global code static.
> > 
> > Looks good to me -- but have you tested it?  If so, I will ack, otherwise
> > I will test and ack/nack depending on the results.
> 
> I've only tested the compilation (which should be enough considering the 
> nature of the patch).

Perhaps it should be, but I am paranoid.  Too many ways for compilers,
include files, and CPP macros to play tricks.  I will test it.

							Thanx, Paul
