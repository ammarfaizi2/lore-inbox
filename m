Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265599AbSJXSlF>; Thu, 24 Oct 2002 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265601AbSJXSlF>; Thu, 24 Oct 2002 14:41:05 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:58633 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265599AbSJXSlE>; Thu, 24 Oct 2002 14:41:04 -0400
Date: Thu, 24 Oct 2002 19:47:10 +0100
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Cc: cminyard@mvista.com
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
Message-ID: <20021024184710.GA11093@compsoc.man.ac.uk>
References: <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com> <20021024144632.GC32181@compsoc.man.ac.uk> <3DB81376.90403@mvista.com> <20021024171815.GA6920@compsoc.man.ac.uk> <3DB83156.5000402@mvista.com> <20021024180435.GB8915@compsoc.man.ac.uk> <3DB83CC8.7070607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB83CC8.7070607@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *184n0g-0007DA-00*IDJrNRmKXkY* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 01:32:40PM -0500, Corey Minyard wrote:

> Do you know if nmi_shutdown in oprofile/nmi_int.c can be called from 

It can only be called in process context, from the event buffer
release() method (and open(), on the failure path)

regards
john
-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath
