Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261518AbVA1S72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261518AbVA1S72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbVA1S5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:57:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:21687 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbVA1SwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:52:14 -0500
Date: Fri, 28 Jan 2005 10:52:17 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Lorenzo =?ISO-8859-1?B?SGVybuFuZGV6IEdhcmPtYS1IaWVycm8=?= 
	<lorenzo@gnu.org>
Cc: netdev@oss.sgi.co,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
Message-ID: <20050128105217.1dc5ef42@dxpl.pdx.osdl.net>
In-Reply-To: <1106937110.3864.5.camel@localhost.localdomain>
References: <1106932637.3778.92.camel@localhost.localdomain>
	<20050128100229.5c0e4ea1@dxpl.pdx.osdl.net>
	<1106937110.3864.5.camel@localhost.localdomain>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 19:31:50 +0100
L
> > Okay, but:
> > * Need to give better explanation of why this is required, 
> >   existing randomization code in network is compromise between
> >   performance and security. So you need to quantify the performance
> >   impact of this, and the security threat reduction.
> 
> Performance impact is none AFAIK.
> I've explained them in an early reply to Adrian [1].

When I did the port randomization patch the benchmark that was most impacted
was LMBENCH.  The biggest change was in the communications latency results.

If you want, you can sign up for a free access to OSDL test machines
and use STP to run lmbench and easily get before/after results.

1. Go to osdl.org and get associate account http://osdl.org/join_form

2. Submit patch to Patch Lifecycle Manager http://osdl.org/plm-cgi/plm

3. Choose test to run Scalable Test Platform (STP) 
http://osdl.org/lab_activities/kernel_testing/stp/


-- 
Stephen Hemminger	<shemminger@osdl.org>
