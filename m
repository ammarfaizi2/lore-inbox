Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRJXQ3r>; Wed, 24 Oct 2001 12:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278642AbRJXQ3h>; Wed, 24 Oct 2001 12:29:37 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:52494
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S278625AbRJXQ3Y>; Wed, 24 Oct 2001 12:29:24 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200110241534.f9OFYnL14565@www.hockin.org>
Subject: Re: issue: deleting one IP alias deletes all
To: cfriesen@nortelnetworks.com (Christopher Friesen)
Date: Wed, 24 Oct 2001 08:34:48 -0700 (PDT)
Cc: david@blue-labs.org (David Ford), ja@ssi.bg (Julian Anastasov),
        thockin@sun.com (Tim Hockin),
        linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <3BD6CA13.613B22EE@nortelnetworks.com> from "Christopher Friesen" at Oct 24, 2001 10:02:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Switch to 'ip' instead of 'ifconfig', several large distros now include
> > it.  Addresses can be added and removed completely indiscriminately on
> > interfaces.
> > 
> > The "ethN:X" is a legacy design that is now deprecated.
> 
> Minor issue...if I create (using 'ip') two addresses on the same subnet on the
> same device, one of them is primary and the other is secondary.  If I then
> delete the primary address, the second one goes with it.
> 
> I submit that this is bad behaviour.


This is the same behavior for which I am proposing fixing.  The origin of
the thread, if you will.

Tim
