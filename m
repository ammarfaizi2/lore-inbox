Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTF1B7h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 21:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265023AbTF1B7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 21:59:37 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63703 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S265022AbTF1B7e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 21:59:34 -0400
Date: Fri, 27 Jun 2003 19:13:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: bcollins@debian.org, davidel@xmailserver.org, davem@redhat.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <36630000.1056766403@[10.10.2.4]>
In-Reply-To: <20030627181432.61bf6f3a.akpm@digeo.com>
References: <20030626.224739.88478624.davem@redhat.com><21740000.1056724453@[10.10.2.4]><Pine.LNX.4.55.0306270749020.4137@bigblue.dev.mcafeelabs.com><20030627.143738.41641928.davem@redhat.com><Pine.LNX.4.55.0306271454490.4457@bigblue.dev.mcafeelabs.com><20030627213153.GR501@phunnypharm.org><20030627162527.714091ce.akpm@digeo.com><35240000.1056760723@[10.10.2.4]> <20030627181432.61bf6f3a.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@digeo.com> wrote (on Friday, June 27, 2003 18:14:32 -0700):

> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>> 
>>  I think your suggestion of sending new bugs out to LKML has made a big
>>  dent in the one<->one problem already. Replacing all the default owner 
>>  fields with mailing lists (either existing ones or new ones) instead of 
>>  individuals would be another step in that direction, though there may
>>  be a few hurdles to deal with on the way to that.
>> 
>>  Yes, we probably also need an "email back in" interface as we've 
>>  discussed before to take it up to many-many.
> 
> Both these things would help heaps - the tracking system then
> becomes invisible, basically.  The best of both.  Can we make it so?

The answer to both is yes, but one's harder than the other ;-)

1. default owners -> lists:

Setting default owners to existing lists is somewhat invasive, and
might provoke riots ;-) Not only do you get the new bug notification,
but also any updates, which may become irritating. There's probably 
some vaguely happy medium to be found between: 
	a) sending newly logged bugs to existing lists,
	b) sending updates to some new list.
Maybe if we just create a new list for each category, and let
people subscribe at will to those ... and I keep sending newly logged
bugs to linux-kernel? I can cc netdev / linux-scsi / whatever on those
new ones if that helps?

That seems reasonably helpful and non-invasive to people who don't
want to see it to me. People who like the mailing lists will see the 
new bug reports, and can just delete and forget them (as now). I'll
go with the consensus of opinion (ha!) on this ... I'd like to make
it useful without getting lynched ;-) Using new lists makes it less
intrusive. Any way we go here is fairly easy to set up.

2. email back in.

Email back in is harder, and needs more thought as to how to make it
easy to use, whilst avoiding logging crap (eg. ensuing flamewars that 
derive from the bug reports, etc). My intuition is to log replies by
default, and hack off certain threads by hand by keeping track of 
replies-to headers or something. Not desperately enamoured with that,
but it's the best I can think of, off the top of my head. Open to 
other ideas ...

Anyway, that bit is definitely a longer term project (ie not going to 
happen next week, but maybe in a few weeks).

M.


