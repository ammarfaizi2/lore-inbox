Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268448AbUJDGWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268448AbUJDGWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 02:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268453AbUJDGWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 02:22:42 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25022 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268448AbUJDGWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 02:22:39 -0400
Date: Sun, 3 Oct 2004 23:20:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alan@lxorguk.ukuu.org.uk, olaf+list.linux-kernel@olafdietsche.de,
       george@mvista.com, akpm@osdl.org, juhl-lkml@dif.dk, clameter@sgi.com,
       drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com,
       Simon.Derr@bull.net
Subject: Re: [OT] Re: patches inline in mail
Message-Id: <20041003232033.7790445f.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.60.0410032255360.5054@poirot.grange>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
	<4154F349.1090408@redhat.com>
	<Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
	<41550B77.1070604@redhat.com>
	<B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
	<Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
	<4159B920.3040802@redhat.com>
	<Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
	<415AF4C3.1040808@mvista.com>
	<Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
	<415B0C9E.5060000@mvista.com>
	<Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
	<415B4FEE.2000209@mvista.com>
	<20040930222928.1d38389f.akpm@osdl.org>
	<1096633681.21867.14.camel@localhost.localdomain>
	<415DD31A.3020004@mvista.com>
	<87vfdtglrx.fsf@goat.bogus.local>
	<1096730402.25131.18.camel@localhost.localdomain>
	<Pine.LNX.4.60.0410032255360.5054@poirot.grange>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guennadi wrote:
> However, everybody (not pine-users) complains, that white spaces got 
> corrupted. And if I export the email I see ...

I complained about the same extra space to a colleague of mine,
Simon Derr <Simon.Derr@bull.net>.

A day later, Simon wrote back to me:
> I think I found the culprit:
> pine 4.60 and later have a feature about 'flowed text' that has to be
> explicitely turned off and that messes with whitespaces.

And indeed, that fixed his patches, from my perspective.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
