Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264250AbTDWUJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbTDWUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 16:09:40 -0400
Received: from [66.212.224.118] ([66.212.224.118]:32010 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S264250AbTDWUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 16:09:36 -0400
Date: Wed, 23 Apr 2003 16:13:42 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrew Morton <akpm@digeo.com>,
       Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.67-mm4 & IRQ balancing
In-Reply-To: <Pine.LNX.3.96.1030423153128.4451E-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.50.0304231610030.27414-100000@montezuma.mastecende.com>
References: <Pine.LNX.3.96.1030423153128.4451E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Apr 2003, Bill Davidsen wrote:

> I like the idea of being able to tune the int processing with a user
> program. I don't think I share your vision of making a user program part

You've actually been able to do this with echo(1) for a while, just not 
'automagically'

> of the kernel to allow diddling an interface which might be better getting
> right the first time, and protecting against "features" being added.
> Hopefully it will be minimalist, and may well benefit from a totally
> different user program for various machine types.

The smp interrupt affinity interface hasn't changed for a while (since 
inception?), we're only now deciding on where to put the autotune aspect 
of it.

	Zwane

--
function.linuxpower.ca
