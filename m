Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932541AbWAFCHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWAFCHX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 21:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752215AbWAFCHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 21:07:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14060 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751901AbWAFCHV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 21:07:21 -0500
Date: Thu, 5 Jan 2006 15:54:36 -0500
From: Dave Jones <davej@redhat.com>
To: Avishay Traeger <atraeger@cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060105205436.GO20809@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Avishay Traeger <atraeger@cs.sunysb.edu>,
	linux-kernel@vger.kernel.org
References: <20060105045212.GA15789@redhat.com> <1136469533.21485.91.camel@rockstar.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136469533.21485.91.camel@rockstar.fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 08:58:53AM -0500, Avishay Traeger wrote:
 > Some comments:
 > 1. I think this is a good idea, since serial consoles can also change
 > timings.  I have seen several race conditions where the problem goes
 > away once I add a serial console.
 > 2. Should this be a separate debugging option?

maybe

 > 3. Shouldn't you have KERN____ in your printk statements?

doesn't make a great deal of difference in this context.

 > 4. Wouldn't printing out the message every second make the oops scroll
 > off the screen, defeating the purpose of the patch?

no. that's why it uses \r instead of \n.

		Dave

