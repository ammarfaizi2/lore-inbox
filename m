Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291745AbSCRSop>; Mon, 18 Mar 2002 13:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291753AbSCRSof>; Mon, 18 Mar 2002 13:44:35 -0500
Received: from sbcs.sunysb.edu ([130.245.1.15]:60878 "EHLO sbcs.cs.sunysb.edu")
	by vger.kernel.org with ESMTP id <S291745AbSCRSoP>;
	Mon, 18 Mar 2002 13:44:15 -0500
Date: Mon, 18 Mar 2002 13:40:36 -0500 (EST)
From: <prade@cs.sunysb.edu>
X-X-Sender: <prade@compserv3>
To: Robert Pfister <robertp@ustri.com>
cc: <linux-kernel@vger.kernel.org>
Subject: RE: Trapping all Incoming Network Packets 
In-Reply-To: <003501c1ceaa$91678f90$1e00a8c0@nomaam>
Message-ID: <Pine.GSO.4.33.0203181330530.5841-100000@compserv3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Robert Pfister wrote:

> There are ways to accomplish similar things in user space. Is there some
> reason that you need to do this in the kernel? What is your end-goal with
> this?
>
> Robb
>

To do it in user space, you have to use the raw socket interface. This
by-passes the entire TCP/IP stack. I want to sniff the packets, and make a
decision based on certain characteristics of each packet. So I need to
have a filter between the IP and link-layer. Also, I do not want the
filter to slow down traffic. Hence I believe implementing inside kernel
will be more efficient.

-- pradipta

