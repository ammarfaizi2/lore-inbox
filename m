Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266772AbSKHIHz>; Fri, 8 Nov 2002 03:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266774AbSKHIHy>; Fri, 8 Nov 2002 03:07:54 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:27151 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S266772AbSKHIHy>;
	Fri, 8 Nov 2002 03:07:54 -0500
Date: Fri, 8 Nov 2002 09:14:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Colin Burnett <cburnett@fractal.candysporks.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: pure raw eth sockets
Message-ID: <20021108081429.GF879@alpha.home.local>
References: <1036735964.3dcb55dc6f784@www.candysporks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036735964.3dcb55dc6f784@www.candysporks.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 12:12:44AM -0600, Colin Burnett wrote:
> I'm at a complete road block here and I appreciate any help!
> 
> I'm trying to write a packet generator that generates a packet down to the
> destination/src mac address of an eth frame.  However, nothing I find seems to
> explain how to do this let alone if it is possible.  As example (for
> familiarity), implementing a RARP client (and server).  I first create a socket:

I wrote a tool which works exactly like this, to test network equipments to
limits. It's slightly commented, and relatively basic. You can download it
there :

   http://w.ods.org/tools/ethforge/

Just a tip: don't start it without args, by default it will bomb as many
packets as possible on your network! Read it first :-)

Cheers,
Willy

