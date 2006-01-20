Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWATROb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWATROb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 12:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWATROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 12:14:30 -0500
Received: from free.wgops.com ([69.51.116.66]:12558 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1750939AbWATROa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 12:14:30 -0500
Date: Fri, 20 Jan 2006 10:14:15 -0700
From: Michael Loftis <mloftis@wgops.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Marc Koschewski <marc@osknowledge.org>, linux-kernel@vger.kernel.org
Subject: Re: Development tree, PLEASE?
Message-ID: <5F952B75937998C1721ACBA8@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
 <20060120155919.GA5873@stiffy.osknowledge.org>
 <B6DE6A4FC14860A23FE95FF3@d216-220-25-20.dynip.modwest.com>
 <Pine.LNX.4.61.0601201738570.10065@yvahk01.tjqt.qr>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On January 20, 2006 5:41:13 PM +0100 Jan Engelhardt 
<jengelh@linux01.gwdg.de> wrote:

>
>> Lots of things still out there depend on devfs.  So now if I want to
>> develop my kmod on recent kernels I have to be in the business of
>> maintaining a lot more userland stuff, like mkinitrd, installers, etc.
>> that have come to rely on devfs.
>
> Just like the OSS-ALSA/e100 debate: If there IS something that you
> do not like [something that requires devfs], why has NO ONE objected?
> (Quoting Greg: "and I have not heard a single peep out of anyone about
> the  email titled "Subject: devfs going away, last chance to complain"")
> Not to  forget there is ndevfs if you really need it.

Unfortunately I wasn't pushing on bleeding edge kernels when that thread 
happened and I apologize for not speaking up then, but this is much larger 
than just devfs.  This is the need for development to get off the stable 
kernel, and onto a development branch where it belongs so we can quit 
breaking things for the stable kernel.  Unless the intent is to just not 
have a stable kernel anymore.  If it is, then fine, lets see word from the 
forces that be along those lines.

I'm just calling things as they are, right now, 2.6 is development, and 
unstable.  Yes it runs without crashing and is stable in that sense, but so 
are a goodly lot/most of the 2.5 series (heck I ran a decent chunk of that 
in production).

The problem here is I'm spending a lot of my time lately fixing things that 
shouldn't need fixing.  Things that are/were developed against what was 
supposed to be a stable major version and has been turned into a 
development version.

I realise that there are/have been policy changes, and I can see the need 
and reason behind those, and I agree with them on the front, more 
development is good.  But it should be done in a development branch, 
because otherwise it makes it damn near impossible to maintain when the 
world is slowly changing under you.

It's easier for an embedded system especially to pick a target, and then 
stay with it.  Later when a new major version comes out the time can then 
be invested ONCE to redevelop what needs redeveloping, which is easier to 
do (yes I'm speaking from a business standpoint, sorry, but someone has to) 
and to sell to management than nickel-and-dime to death of trying to follow 
a development tree.
