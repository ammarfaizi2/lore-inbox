Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263378AbRFNRFg>; Thu, 14 Jun 2001 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbRFNRF0>; Thu, 14 Jun 2001 13:05:26 -0400
Received: from schmee.sfgoth.com ([63.205.85.133]:27657 "EHLO
	schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S263378AbRFNRFT>; Thu, 14 Jun 2001 13:05:19 -0400
Date: Thu, 14 Jun 2001 10:04:47 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: dan.davidson@conexant.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup in 2.4.2 kernel ADSL PCI card ATM driver module
Message-ID: <20010614100447.A32912@sfgoth.com>
In-Reply-To: <OF498D9381.A68AAD65-ON86256A6B.005A1479@conexant.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <OF498D9381.A68AAD65-ON86256A6B.005A1479@conexant.com>; from dan.davidson@conexant.com on Thu, Jun 14, 2001 at 11:37:50AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan.davidson@conexant.com wrote:
> SUBJECT:
> Lockup in 2.4.2 kernel ADSL PCI card ATM driver module
> 
> 
> DRIVER RESULTS:
> Works fine in 2.4.0 kernel.
> Locks up system (no messages/oops/etc.) in 2.4.2-2 kernel (rh 7.1).
> Locks up system (no messages/oops/etc.) in 2.4.2 kernel (w/ or w/o kgdb).
> Locks up system with "int 3" ??????? message in 2.4.2-ac28 kernel.

First, please try with a recent 2.4.5ac kernel - a number of ATM bugfixes
have been made recently and they've been merged first with alan's
branch.  Anyway, there's a chance that you might just be hitting one of
those bugs that have already been fixed, so it'd be best to try that
first so we can exclude that possibility.

> MESSAGE GENERATED IN 2.4.2-ac28:
> int 3: 0000
> CPU:     0
> EIP:     0010:[<c885478b>]

Please read the REPORTING-BUGS and Documentation/oops-tracing.txt files
in the linux source tree - especially the parts about using the
"ksymoops" tool.  These numbers are useless to us unless you run it
through that tool first.

-Mitch
