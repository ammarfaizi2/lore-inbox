Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264842AbTIDU1L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 16:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264839AbTIDU1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 16:27:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37897
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264842AbTIDU1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 16:27:06 -0400
Date: Thu, 4 Sep 2003 13:27:07 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Clark <jimwclark@ntlworld.com>
Cc: Albert Cahalan <albert@users.sf.net>, linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030904202707.GF13676@matchmail.com>
Mail-Followup-To: James Clark <jimwclark@ntlworld.com>,
	Albert Cahalan <albert@users.sf.net>, linux-kernel@vger.kernel.org
References: <1062637356.846.3471.camel@cube> <200309042114.45234.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309042114.45234.jimwclark@ntlworld.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 09:14:45PM +0100, James Clark wrote:
> Thank you for this (and the few other) sensible appraisal of my 'proposal'. 
> 
> I'm very surprised by the number of posts that have ranted about Open/Close 
> source, GPL/taint issues etc. This is not about source code it is about 
> making Linux usable by the masses. It may be technically superior to follow 
> the current model, but if the barrier to entry is very high (and it is!) then 
> the project will continue to be a niche project. A binary model doesn't alter 
> the community or the benefits of public source code. I agree that it is an 
> extra interface and will carry a performance hit - I think this is worth it. 

The thing is, most Linux developers (and I'm sure it's above 51% or maybe
they're just louder?) want drivers to be GPL compatible open source.  Having
a static binary driver interface just doesn't mix very well for that.  And
as things happen (and how it should be), in a well kept stable series, the
binary interfaces won't change that much.  But it will change for different
options, like SMP, preempt, numa, etc.

> Windows has many faults but drivers are often compatible across major 
> releases and VERY compatible across minor releases. It is no accident that it 
> has 90% of the desktop market. If we are going to improve this situation this 
> issue MUST be confronted.

Have you ever seen the source code available for a windows driver?  Windows
doesn't let you customize the kernel.  You just get what they give you.
With the customization possible in Linux you get many advantages, and the
disadvantage that the binary interface can change depending on the compile
options.
