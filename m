Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbVGGGys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbVGGGys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVGGGxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:53:02 -0400
Received: from web81308.mail.yahoo.com ([206.190.37.83]:64397 "HELO
	web81308.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261206AbVGGGuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:50:35 -0400
Message-ID: <20050707065030.4234.qmail@web81308.mail.yahoo.com>
Date: Wed, 6 Jul 2005 23:50:30 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Patch of a new driver for kernel 2.4.x that need review
To: Pekka J Enberg <penberg@cs.helsinki.fi>,
       Mark Gross <mgross@linux.intel.com>
Cc: Willy Tarreau <willy@w.ods.org>, Pekka Enberg <penberg@gmail.com>,
       "Bouchard, Sebastien" <Sebastien.Bouchard@ca.kontron.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Lorenzini, Mario" <mario.lorenzini@ca.kontron.com>
In-Reply-To: <courier.42CCC4F1.000037C0@courier.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> Mark Gross writes:
> 
> > +
> > +/* 0 = Dynamic allocation of the major device number */
> > +#define TLCLK_MAJOR 252
> 
> Enums, please. 
> 

But not here - it is a single constant, not a value of a distinct type.

-- 
Dmitry
