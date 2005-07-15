Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVGOCUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVGOCUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbVGOCSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:18:30 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:19767 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263184AbVGOCQ4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:16:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qvdulGBXLLW9XVtQuNiisGnTWFiQc6LxIBJiqRnDu7dEK6DC7A+PX1Kyht01KdR9MxPIglnXqdga4Crs5mA1fGDWnW14UY1cQJ6Z1KKxbnTgc/xyjWUO5xlb2n0mrmN/HaA98ZZqXwjyiGnnynW5yREUve/LsAAfk74MjKI7fl0=
Message-ID: <21d7e997050714191666656d5@mail.gmail.com>
Date: Fri, 15 Jul 2005 12:16:55 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Cc: Chris Friesen <cfriesen@nortel.com>, Andi Kleen <ak@suse.de>,
       Mark Gross <mgross@linux.intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490507141906fb7e5b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel>
	 <p73wtnsx5r1.fsf@bragg.suse.de>
	 <9a8748490507141845162c0f19@mail.gmail.com>
	 <42D71950.20303@nortel.com> <9a8748490507141906fb7e5b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That, of course, you cannot do. But, you can regression test a lot of
> other things, and having a default test suite that is constantly being
> added to and always being run before releases (that test hardware
> agnostic stuff) could help cut down on the number of regressions in
> new releases.
> You can't test everything this way, nor should you, but you can test
> many things, and adding a bit of formal testing to the release
> procedure wouldn't be a bad thing IMO.

But if you read peoples complaints about regression they are nearly
always to do with hardware that used to work not working any more ..
alps touchpads, sound cards, software suspend.. so these people still
gain nothing by you regression testing anything so you still get as
many reports.. the -rc series is meant to provide the testing for the
release so nothing really big gets through (like can't boot from IDE
anymore or something like that)....

Dave.
