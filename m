Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265446AbTFMRTl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265449AbTFMRTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:19:41 -0400
Received: from mail.ithnet.com ([217.64.64.8]:1805 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265446AbTFMRTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:19:37 -0400
Date: Fri, 13 Jun 2003 19:33:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David Rees" <dbr@greenhydrant.com>
Cc: mdresser_l@windsormachine.com, linux-kernel@vger.kernel.org
Subject: Re: 3ware and two drive hardware raid1
Message-Id: <20030613193309.2d538c31.skraw@ithnet.com>
In-Reply-To: <3570.66.75.244.69.1055521381.squirrel@www.greenhydrant.com>
References: <1055494998.5162.26.camel@dhcp22.swansea.linux.org.uk>
	<Pine.LNX.4.33.0306131017010.16766-100000@router.windsormachine.com>
	<3570.66.75.244.69.1055521381.squirrel@www.greenhydrant.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jun 2003 09:23:01 -0700 (PDT)
"David Rees" <dbr@greenhydrant.com> wrote:

> Mike Dresser said:
> >
> > I'm heading out there today to take a look at the machine and see what
> > happened.  I'm rather dissappointed in the 3ware utility, it alternately
> > claims both drives are ok(./tw_cli info c1 is different from ./tw_cli
> > info c1 u0)
> >
> > I was relying on that too much, and ignored the possiblity of two drive
> > failure.  Looks like both drives would have failed at exactly the same
> > time, which sounds like a power spike.
> 
> On the 3ware boxes I use, I setup the 3DM utility to run weekly scans of
> the unit to look for badblocks, do you do the same thing?  I've had the
> scan turn up bad disks before.
> 
> -Dave

I can confirm that the 3dm daemon is very handy. Especially the media scan is
highly recommended, as it finds problems on areas where there is no production
data yet. So there always is a good chance for replacement before actual failure.

Regards,
Stephan
