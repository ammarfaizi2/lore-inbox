Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSFNBT1>; Thu, 13 Jun 2002 21:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317865AbSFNBT0>; Thu, 13 Jun 2002 21:19:26 -0400
Received: from gomez.cs.pitt.edu ([136.142.79.193]:26306 "EHLO
	gomez.cs.pitt.edu") by vger.kernel.org with ESMTP
	id <S317864AbSFNBTZ>; Thu, 13 Jun 2002 21:19:25 -0400
Date: Thu, 13 Jun 2002 21:19:26 -0400 (EDT)
From: Sanjeev Dwivedi <sanjeev@cs.pitt.edu>
To: linux-kernel@vger.kernel.org
Subject: Changing IP Routing
Message-ID: <Pine.OSF.4.21.0206132112440.22673-100000@bert.cs.pitt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are developing an adhoc routing protocol in linux. What we wish to do is to replace the
routing functionality of IP with a new functionality which we plan to implement. 

What we have narrowed down to is that we need to replace the functions
ip_route_input, ip_route_output (probably ip_route_input_slow and ip_route_output_slow as well)
with functions of identical names which return routes decided by our protocol rather
than the default.

What we would really like to know is whether the above mentioned functions are all that
are needed to be changed to change the routing functionality of IP or is there some other 
factor(functions, places) to be looked over as well.

any help will be greatly appreciated.

thanks

sanjeev dwivedi
anandha gopalan

