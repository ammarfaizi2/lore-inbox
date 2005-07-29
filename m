Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbVG2VdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbVG2VdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVG2V15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:27:57 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20634 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262878AbVG2V0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:26:45 -0400
Date: Fri, 29 Jul 2005 23:22:22 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why dump_stack results different so much?
Message-ID: <20050729212221.GA32570@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c140507291327143a9d83@mail.gmail.com> <20050729203403.GA30603@outpost.ds9a.nl> <4ae3c140507291400230ca65c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140507291400230ca65c@mail.gmail.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 05:00:20PM -0400, Xin Zhao wrote:
> Thanks for your reply.
> 
> Below is the code that print the kernel calling trace:

Can I suggest just turning on frame pointers like I suggested? 

 If you say Y here the resulting kernel image will be slightly larger
 and slower, but it will give very useful debugging information. 
 If you don't debug the kernel, you can say N, but we may not be able
 to solve problems without frame pointers. 

Good luck!

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
