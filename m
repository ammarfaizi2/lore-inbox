Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbTCOXwA>; Sat, 15 Mar 2003 18:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbTCOXwA>; Sat, 15 Mar 2003 18:52:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11228
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261634AbTCOXv7>; Sat, 15 Mar 2003 18:51:59 -0500
Subject: Re: dual AMD MP 2000+ and ASUS A7M266-D problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dale Harris <rodmur@maybe.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030314231227.GA19468@maybe.org>
References: <20030314231227.GA19468@maybe.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047777123.1335.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 01:12:04 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 23:12, Dale Harris wrote:
> 1 or 2 CPU with more than 1 DIMM, lucky to last 20 minutes, usually
> less.
> 
> I have tried each of the four DIMMs individually, they all appear to be
> fine.  
> 
> So I'm wondering if anyone has any insight into what the problem might
> be.  Is underclocking the chips all I can do?

The A7M266-D is infamously picky about the PSU, about the DIMM quality
and about the heat handling. Its one of the reasons I suspect that the
dual athlon didn't get AMD into the enterprise market - goes like a
rocket, requires space shuttle grade components and produces as much
heat.

I am using dual cpu and two dimms (ecc, registered). Contrary to the
docs I've never managed to get it stable with 3 dimms.

Also make sure you use a recommended PSU, many 400W PSU's don't
produce the right amount of power on the right voltage lines. 

Alan

