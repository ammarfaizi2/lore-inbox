Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263162AbUEOB0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263162AbUEOB0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 21:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265308AbUEOB0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 21:26:04 -0400
Received: from fmr99.intel.com ([192.55.52.32]:58088 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263162AbUEOBXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 21:23:03 -0400
Subject: Re: keventd takes 99% of CPU when laptop lid is closed
From: Len Brown <len.brown@intel.com>
To: Antille Julien <julien.antille@eivd.ch>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB5D0@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB5D0@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084584164.12353.294.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 May 2004 21:22:44 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 03:29, Antille Julien wrote:

> > Antille Julien <julien.antille@eivd.ch> wrote:
> > > On 2.4.26, 2.6.5 and 2.6.6, the kernel process keventd takes 99%
> of CPU
> > > when my laptop's lid is closed. It comes back to normal when I
> open it
> > > again. Laptop is a DELL Inspirion 2650.
> > >
> > > This problem did not occure with <=2.4.25 or <= 2.6.4
> >

I expect this is related to the broken state of GPE's.
Bob just completed his GPE re-write -- I'll have it
in the testing tree shortly and hopefully you'll
be able to test it out for us when it hits -mm.

thanks,
-Len


