Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUI3D0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUI3D0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 23:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268648AbUI3D0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 23:26:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22733 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268536AbUI3D0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 23:26:02 -0400
Date: Wed, 29 Sep 2004 20:24:28 -0700
From: Paul Jackson <pj@sgi.com>
To: george@mvista.com
Cc: juhl-lkml@dif.dk, clameter@sgi.com, drepper@redhat.com,
       johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
Message-Id: <20040929202428.19bdabae.pj@sgi.com>
In-Reply-To: <415B4FEE.2000209@mvista.com>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George wrote:
> Still, I have been bitten too many times by misshandled white space 
> to trust pure inlineing. 

I use a script to send any patches I care much about, rather than my
email client.  The script sends the file directly to my SMTP server.

Especially when sending more than one related patch, I find it much more
accurate to prepare the small text file indicating To, Cc, Bcc, Subject,
local-patch-pathname for each patch in the set at my leisure, in my text
editor, until it all looks right, then issue a single command to send it
all off.

Email clients, especially the gui ones I'm fond of, are not well
suited to such work.

There are various such 'patch-bomb' scripts out there - mine is
available at:

	http://www.speakeasy.org/~pj99/sgi/sendpatchset

See the embedded Usage string for documentation.

The script checks out everything it can, including file paths and email
addresses (by verifying them with the SMTP server) before it sends
anything, further increasing the chance that if something is sent, it's
all sent and correctly so.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
