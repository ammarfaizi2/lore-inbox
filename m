Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUDKRDn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 13:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUDKRDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 13:03:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58827 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262425AbUDKRDm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 13:03:42 -0400
Date: Sun, 11 Apr 2004 18:03:40 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: List of oversized inlines
Message-ID: <20040411170340.GB1287@gallifrey>
References: <200404111905.49443.vda@port.imtp.ilyichevsk.odessa.ua> <20040411163255.GB6248@waste.org> <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404111951.34734.vda@port.imtp.ilyichevsk.odessa.ua>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.5 (i686)
X-Uptime: 18:01:59 up 21:03,  1 user,  load average: 0.10, 0.04, 0.01
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be careful in making judgements about the inlining behaviour based
on sizes on one architecture.  The size of these functions
is likely to be radically different on different architectures, and
the break off point of cache/RAM usage v branch cost is also likely
to be entirely different.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
