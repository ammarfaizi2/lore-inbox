Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261942AbRFGQos>; Thu, 7 Jun 2001 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261968AbRFGQoi>; Thu, 7 Jun 2001 12:44:38 -0400
Received: from [208.48.139.185] ([208.48.139.185]:27339 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S261942AbRFGQoY>; Thu, 7 Jun 2001 12:44:24 -0400
Date: Thu, 7 Jun 2001 09:44:18 -0700
From: David Rees <dbr@greenhydrant.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
Message-ID: <20010607094418.A23719@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3B1F51DB.54BE78CA@iph.to> <Pine.LNX.4.21.0106071519120.3702-100000@ns1.Aniela.EU.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0106071519120.3702-100000@ns1.Aniela.EU.ORG>; from lk@Aniela.EU.ORG on Thu, Jun 07, 2001 at 03:20:03PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2001 at 03:20:03PM +0300, L. K. wrote:
> On Thu, 7 Jun 2001, Philips wrote:
> 
> > 	Kelvins good idea in general - it is always positive ;-)
> > 
> > 	0.01*K fits in 16 bits and gives reasonable range.
> > 
> > 	but may be something like K<<6 could be a option? (to allow use of shifts
> > instead of muls/divs). It would be much more easier to extract int part.
> > 
> > 	just my 2 eurocents.
> 
> Why not make it in Celsius ? Is more easy to read it this way.

It's easier for you as a user to read, but slightly harder to deal with inside the code.  
It's really a user-space issue, inside the kernel should be as standardized as possible, and
Kelvins make the most sense there.

-Dave
