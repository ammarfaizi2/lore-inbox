Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267388AbUJGPkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267388AbUJGPkh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267397AbUJGPkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:40:37 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:28581 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267388AbUJGPkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 11:40:31 -0400
Message-ID: <e7963922041007083940ed74f4@mail.gmail.com>
Date: Thu, 7 Oct 2004 17:39:46 +0200
From: Stefan Schweizer <sschweizer@gmail.com>
Reply-To: Stefan Schweizer <sschweizer@gmail.com>
To: Steve M <stevenm@umd.edu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RadeonFB ACPI S3 patch fixed to not break S4. 2.6.8.1, 2.6.7
In-Reply-To: <1097134935.7805.1.camel@stevenm-laptop.student.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1096868582.10456.9.camel@stevenm-laptop.student.umd.edu>
	 <e796392204100706526247ece2@mail.gmail.com>
	 <1097134935.7805.1.camel@stevenm-laptop.student.umd.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Nice that you also have the same problem.
Do you have any clue what driver is causing this? Its really annoying
for me with S3.
Perhaps I could figure it out with more verbose messages, any I dea
how to get them?

Stefan

On Thu, 07 Oct 2004 03:42:15 -0400, Steve M <stevenm <aaatt> umd.edu> wrote:
> Hello.
> Mine does this occasionally. I do not really understand why. Some say it
> is because some things are missing interrupts, and I will try some more
> rigorous mudile unloading and modulizing of things compiled in. Having
> to press a key doesn't bother me that much, because with this modified
> patch Suspend-to-Disk works again. I will play around with it further,
> though.
> 
> On Thu, 2004-10-07 at 15:52 +0200, Stefan Schweizer wrote:
> > Your patch has the same problem as Oles for me. It stops after
> > "radeonfb: resumed !". If I press a key then, it proceedes.
