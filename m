Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264346AbUD0Uou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbUD0Uou (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 16:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbUD0Uot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 16:44:49 -0400
Received: from [80.72.36.106] ([80.72.36.106]:55176 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264346AbUD0Uoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 16:44:46 -0400
Date: Tue, 27 Apr 2004 22:44:39 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Timothy Miller <miller@techsource.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Marc Boucher <marc@linuxant.com>, Adam Jaskiewicz <ajjaskie@mtu.edu>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, torvalds@osdl.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <408EC478.9090502@techsource.com>
Message-ID: <Pine.LNX.4.58.0404272240170.9618@alpha.polcom.net>
References: <20040427165819.GA23961@valve.mbsi.ca> <408E9771.7020302@mtu.edu>
 <F55B44BB-9870-11D8-85DF-000A95BCAC26@linuxant.com> <408E9C59.2090502@nortelnetworks.com>
 <Pine.LNX.4.58.0404271950170.4424@alpha.polcom.net> <408EA22C.4090408@nortelnetworks.com>
 <408EC478.9090502@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Apr 2004, Timothy Miller wrote:
> Chris Friesen wrote:
> > Grzegorz Kulewski wrote:
> >> Maybe kernel should display warning only once per given licence or 
> >> even once per boot (who needs warning about tainting tainted kernel?)
> >
> > I think that's a very good point.  If the kernel is already tainted, 
> > maybe we don't need to print out additional taint messages.
> 
> That could be confusing if it's important for the user to know which 
> modules taint the kernel.  If tainting is only mentioned for the first 
> tainting, then the user might be lead to believe that subsquent ones do 
> not taint the kernel, even though they do.

Ok, so we can write big and fat KERNEL WAS JUST TAINTED warning on first 
tainting module load and then issue only small notices to the log...


Grzegorz Kulewski

