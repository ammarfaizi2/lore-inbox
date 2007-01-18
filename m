Return-Path: <linux-kernel-owner+w=401wt.eu-S932185AbXARMpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXARMpi (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 07:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXARMpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 07:45:38 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:28393 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbXARMpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 07:45:38 -0500
Subject: Re: [PATCH] futex null pointer timeout
From: Daniel Walker <dwalker@mvista.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de, khilman@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <45AF6790.8010000@bull.net>
References: <20070118002503.418478415@mvista.com>
	 <20070118073816.GA28486@elte.hu>  <45AF6790.8010000@bull.net>
Content-Type: text/plain; charset=utf-8
Date: Thu, 18 Jan 2007 04:44:26 -0800
Message-Id: <1169124266.20305.18.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-18 at 13:26 +0100, Pierre Peiffer wrote:
> Ingo Molnar a écrit :
> > * Daniel Walker <dwalker@mvista.com> wrote:
> > 
> [...]
> >> The patch reworks do_futex, and futex_wait* so a NULL pointer in the 
> >> timeout position is infinite, and anything else is evaluated as a real 
> >> timeout.
> > 
> > thanks, applied.
> > 
> 
> On top of this patch, you will need the following patch: futex_lock_pi is also 
> involved.
> 

True.

Daniel

