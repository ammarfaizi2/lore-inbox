Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265800AbUFRXhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbUFRXhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFRXdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:33:17 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:16594 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264540AbUFRXbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:31:03 -0400
Subject: Re: DMA API issues
From: James Bottomley <James.Bottomley@steeleye.com>
To: Ian Molton <spyro@f2s.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, david-b@pacbell.net, jamey.hicks@hp.com,
       joshua@joshuawise.com
In-Reply-To: <20040619002618.5650e16a.spyro@f2s.com>
References: <20040618175902.778e616a.spyro@f2s.com>
	<40D359B3.6080400@pobox.com>  <20040619002618.5650e16a.spyro@f2s.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 18 Jun 2004 18:30:44 -0500
Message-Id: <1087601446.2134.211.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 18:26, Ian Molton wrote:
> On Fri, 18 Jun 2004 17:08:03 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> > You _might_ convince the kernel DMA gurus that this could be done by 
> > creating a driver-specific bus, and pointing struct device to that 
> > internal bus, but that seems like an awful lot of work as opposed to the 
> > wrappers.
> 
> Its an awful lot less work than re-writing all those drivers!

Every other driver bar this one already copes correctly with on chip
memory using the ioremap methods.  That's why we're all wondering if it
isn't simpler to fix this driver.

James


