Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266521AbSKGMGw>; Thu, 7 Nov 2002 07:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266522AbSKGMGw>; Thu, 7 Nov 2002 07:06:52 -0500
Received: from mail.zmailer.org ([62.240.94.4]:63902 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S266521AbSKGMGv>;
	Thu, 7 Nov 2002 07:06:51 -0500
Date: Thu, 7 Nov 2002 14:13:28 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Majordomo results
Message-ID: <20021107121328.GS26330@mea-ext.zmailer.org>
References: <20021107101602Z266439-32597+17764@vger.kernel.org> <Pine.LNX.4.44.0211071125530.12653-100000@lexx.infeline.org> <20021107103545.B7579@flint.arm.linux.org.uk> <20021107104455.GR26330@mea-ext.zmailer.org> <20021107113938.GC23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107113938.GC23425@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 03:39:38AM -0800, William Lee Irwin III wrote:
> On Thu, Nov 07, 2002 at 12:44:55PM +0200, Matti Aarnio wrote:
> >   It just generates looped messages that are bounced to the list owner.
> >   Subscriber's message had these headers:  (yes, we do log EVERYTHING
> >   sent to Majordomo.. We don't log everything sent to the lists, though.
> >   There are a number of archives for that.)
> 
> Could these DoS attempts get filtered somehow?

  Sorry, its me talking "majordomo" -- when a filter is triggered,
  a "BOUNCE" is sent to the listowner(s) for their analysis and decission.

  So yes, they are filtered already by way of a loop filter we have
  introduced, because every now and then people use MTA/MUA softwares
  that make a mistake at receiving a message and consider visible
  "To:" and "Cc:" headers to carry relevant data for message routing..

  Think a bit of this message; "To:" says  "linux-kernel@vger", but
  it will nevertheless be sent to thousands of recipients whose
  addresses are not visible in these headers at all.
  The Internet Email is routed and transported by SMTP-envelope data,
  which in normal cases is not displayed in visible headers.
  Things in these visible headers have at most incidental relationship
  with actual message routing and destinations.

> Thanks,
> Bill

/Matti Aarnio
