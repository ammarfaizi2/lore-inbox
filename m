Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270343AbRHHFp7>; Wed, 8 Aug 2001 01:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270344AbRHHFpk>; Wed, 8 Aug 2001 01:45:40 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:2320 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S270343AbRHHFpT>;
	Wed, 8 Aug 2001 01:45:19 -0400
Date: Tue, 7 Aug 2001 22:45:00 -0700
From: Greg KH <greg@kroah.com>
To: Stuart Lynne <sl@fireplug.net>, linux-kernel@vger.kernel.org
Subject: Re: How does "alias ethX drivername" in modules.conf work?
Message-ID: <20010807224500.A12601@kroah.com>
In-Reply-To: <20010807135135.J17723@fireplug.net> <20010807223625.A8330@nostromo.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010807223625.A8330@nostromo.devel.redhat.com>; from notting@redhat.com on Tue, Aug 07, 2001 at 10:36:25PM -0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 10:36:25PM -0400, Bill Nottingham wrote:
> Stuart Lynne (sl@fireplug.net) said: 
> > So not being able to reliable map ethernet devices to names is a feature
> > not a bug .... 
> 
> With reasonable scriptage and 'nameif', it's doable. Only for
> ethernet at the moment, however (and I haven't actually implementing
> something that does this.)  But it *is* doable.

With only adding one line to the current linux-hotplug scripts, a
co-worker of mine enabled reliable mapping that isn't dependent on pci
scanning, or hotplugging of pci cards.  He used nameif and a table of
MAC addresses that map to the name he wanted.


greg k-h
