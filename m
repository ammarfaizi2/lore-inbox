Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261989AbSIYOid>; Wed, 25 Sep 2002 10:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261990AbSIYOid>; Wed, 25 Sep 2002 10:38:33 -0400
Received: from gate.in-addr.de ([212.8.193.158]:24083 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261989AbSIYOib>;
	Wed, 25 Sep 2002 10:38:31 -0400
Date: Wed, 25 Sep 2002 16:44:25 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: alternate event logging proposal
Message-ID: <20020925144424.GG1102@marowsky-bree.de>
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C183.5020806@pobox.com> <3D90C3B0.8090507@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D90C3B0.8090507@nortelnetworks.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-09-24T15:57:36,
   Chris Friesen <cfriesen@nortelnetworks.com> said:

I have cut the Cc/To list severely. Couldn't stand it.

> >"What do you want to log?" is as important to me as "how do you want to 
> >log it?"  And the answers to the two questions are very much intertwined.
> Also related is "how can userspace be notified of kernel events?". 
> There is no way for a userspace app to be notified that, for instance, 
> an ATM device got a loss of signal.  The drivers print it out, but the 
> userspace app has no clue.

This is a very generic problem. For example, the Open Clustering Framework
also has a lots of events going back and forth - node membership changes,
distributed locks gained or lost, messages pending etc.

The interesting issue here is that the provider or consumer may be implemented
in kernel or user space depending on the task and the given implementation;
ie, what we would ideally need is a common coherent infrastructure for event
distribution on Linux, as I expect this to be a common task for many
scenarios.

Joe DiMartino of OSDL has developed a very nice Event API (I think) for
user-space (a fixed version with some updates we agreed upon in the last two
weeks is pending), and we are currently evaluating how to interface with the
kernel space.

It would be _very nice_ if someone would pick up the lead wrt to "Event
Processing", so that work is not duplicated between so many (already
overloaded) groups.

Just my few euro-cents.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel
Research and Development, SuSE Linux AG
 
``Immortality is an adequate definition of high availability for me.''
	--- Gregory F. Pfister

