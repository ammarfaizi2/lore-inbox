Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266188AbTLIJjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 04:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266190AbTLIJjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 04:39:40 -0500
Received: from main.gmane.org ([80.91.224.249]:20441 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266188AbTLIJjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 04:39:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Date: Tue, 09 Dec 2003 10:39:32 +0100
Message-ID: <yw1xd6ayib3f.fsf@kth.se>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com>
 <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com>
 <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org>
 <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade>
 <20031209090815.GA2681@kroah.com>
 <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:TFQOF7B696TdXoI3KjLttIgQ9dA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@lsi.nec.co.jp> writes:

>> > >   A:  That is correct.  If you really require this functionality, then
>> > >       use devfs.  There is no way that udev can support this, and it
>> > >       never will.
>> > 
>> > That's something I don't understand: I thought that with a well
>> > configured hotplug+udev system, you'll never have to worry about loading
>> > drivers on device-node open() because all drivers should be auto-loaded
>> > and all device-nodes should be auto-created.
>> 
>> No, you are correct.  That's why I'm not really worried about this, and
>> I don't think anyone else should be either.
>
> Is there a specific case for which people want this feature?
> Offhand it seems like a slightly odd thing to ask for...

I believe the original motivation for module autoloading was to save
memory by unloading modules when their devices were unused.  Loading
them automatically on demand made for less trouble for users, who
didn't have to run modprobe manually to use the sound card, or
whatever.  This could still be a good thing in embedded systems.

-- 
Måns Rullgård
mru@kth.se

