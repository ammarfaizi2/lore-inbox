Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264903AbUG2Sjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUG2Sjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUG2Shj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 14:37:39 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23549 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267518AbUG2ScQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 14:32:16 -0400
Subject: Re: [PATCH] reduce swsusp casting
From: Dave Hansen <haveblue@us.ibm.com>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091049624.2871.464.camel@nighthawk>
References: <1091043436.2871.320.camel@nighthawk>
	 <Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net>
	 <1091049624.2871.464.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1091125918.2871.1874.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Jul 2004 11:31:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 14:20, Dave Hansen wrote:
> On Wed, 2004-07-28 at 14:07, Patrick Mochel wrote:
> > I don't understand - have you really tested it or just compile-tested it?
> > If not, please do try it out for real. There is no reason to be scared of
> > swsusp, and the more people that use it, the more stable it will get.
> 
> I'm not scared, just lazy :)  I'll give it a shot.

Well, I tried with both 2.6.8-rc2-mm1 with and without my patch and got
the exact same results:

# echo disk > /sys/power/state
Stopping tasks: =

Then it freezes.  

Pat, since I'm sure you already have swsusp working on your machine,
would you mind giving my patch a try?  I have the feeling doing a
compile and a couple of boots will be a lot faster than me trying to
debug why it's freezing on me. 

-- Dave

