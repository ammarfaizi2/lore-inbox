Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbTH2KIw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 06:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbTH2KIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 06:08:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:47785 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264514AbTH2KIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 06:08:50 -0400
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, davidsen@tmr.com,
       cswingle@iarc.uaf.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030828194039.7fabf13b.akpm@osdl.org>
References: <20030828131019.69a9f3b9.akpm@osdl.org>
	 <Pine.LNX.3.96.1030828220150.466A-100000@gatekeeper.tmr.com>
	 <32865.4.4.25.4.1062124435.squirrel@www.osdl.org>
	 <20030828194039.7fabf13b.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062151614.26753.11.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 29 Aug 2003 11:06:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-29 at 03:40, Andrew Morton wrote:
> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > Is this the same issue as
> >    http://marc.theaimsgroup.com/?l=linux-kernel&m=106080170017645&w=2
> >  in which AMD said, "Let us get back to you, ok?" on Aug. 13?
> 
> yes.

The extra if also seems to ruin PIV performance, but I still agree with
Andrew - you can test code easily with known oopses. Things like the
known local root holes in 2.6test aren't a problem but random oopses 
mean you can't tell a new bug from the old one.

