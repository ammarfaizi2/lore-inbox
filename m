Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTEWI5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEWI5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:57:39 -0400
Received: from robur.slu.se ([130.238.98.12]:41732 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id S263972AbTEWI5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:57:36 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16077.58738.336652.577890@robur.slu.se>
Date: Fri, 23 May 2003 11:10:10 +0200
To: celestar@t-online.de (Frank Victor Fischer)
Cc: linux-kernel@vger.kernel.org
Subject: Problem with routing in the IPv6 stack
In-Reply-To: <1053469464.2637.10.camel@darkstar.fischer.homeip.net>
References: <1053469464.2637.10.camel@darkstar.fischer.homeip.net>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Frank Victor Fischer writes:

 > I have encountered the following error message when trying to set up a
 > new entry in the IPv6 routing table with the command "ip -6 route add":
 > 
 > RTNETLINK answers: Cannot allocate memory
 > 
 > This has happened after I have had a working IPv6 configuration for
 > several days, and the error message is independent from the interface on
 > which I am trying to establish the route on.
 >
 > vanilla linux kernel 2.4.20 patches with XFS 1.2 and IPsec 1.98b.


 I've heard about this on 2.5.66 as well. /proc/slabinfo can give some clues.

 Cheers.

							--ro
