Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbTFTXYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFTXYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:24:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:44686 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265032AbTFTXYt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:24:49 -0400
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
From: john stultz <johnstul@us.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: Andreas Haumer <andreas@xss.co.at>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1056151705.1162.114.camel@andyp.pdx.osdl.net>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at> <1056151705.1162.114.camel@andyp.pdx.osdl.net>
Content-Type: text/plain
Organization: 
Message-Id: <1056151916.1027.2.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 16:31:56 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 16:28, Andy Pfiffer wrote:
> Update:
> 
> 1) USB legacy support setting in the BIOS had no effect on the problem.
> 2) adding "clock=pit" (as suggested elsewhere) worked around the
> problem.
> 
> So, does this fit the symptoms of:
> http://bugme.osdl.org/show_bug.cgi?id=827

Ok, good to know. I've been working on a fix and hopefully I'll have
something available soon.

> The system is not a laptop, and SpeedStep related issues should not be
> messing things up here.


Hmm. Interesting. Could you send me your dmesg?

thanks
-john


