Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbTFBMR6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFBMR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:17:58 -0400
Received: from pan.togami.com ([66.139.75.105]:19098 "EHLO pan.mplug.org")
	by vger.kernel.org with ESMTP id S262227AbTFBMR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:17:57 -0400
Subject: Re: 2.5.70 kernel BUG include/linux/dcache.h:271!
From: Warren Togami <warren@togami.com>
To: maneesh@in.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030602100204.GE1256@in.ibm.com>
References: <1054545600.2020.602.camel@laptop>
	 <20030602100204.GE1256@in.ibm.com>
Content-Type: text/plain
Message-Id: <1054557040.2020.620.camel@laptop>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (1.3.92-1) (Preview Release)
Date: 02 Jun 2003 02:30:40 -1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 00:02, Maneesh Soni wrote:
> On Mon, Jun 02, 2003 at 09:21:31AM +0000, Warren Togami wrote:
> > Hardware:
> > Sony Vaio FXA36 Athlon laptop
> > Red Hat Linux Rawhide 
> > 
> > After 5 days of uptime on 2.5.70, I noticed this in my dmesg.  I don't
> > know what I was doing at the time when this happened.  Known bug?  Let
> > me know if you want more information about my hardware/software setup.
> > 
> Hi Togami,
> 
> It will be nice if you can provide some information regarding
> the filesystem set up you have in your system. Like which filesystem
> you were using.
> 

Plain ext3 with UTF-8 filenames, no ACLs or Extended Attributes.  It was
created with last week's RH rawhide then I moved to 2.5.70, uptime 5
days now.

Should I be worrying about filesystem corruption now?

> Are you able to recreate this problem?.
> 

Unfortunately no.  I just noticed that message in dmesg after 5 days of
uptime.  Hmm, I just noticed this line within that last post:

 <6>note: updatedb[18515] exited with preempt_count 1

If it happened during updatedb, then it must have been around 22 hours
ago during cron.daily's updatedb.  My laptop was completely idle during
that time.

http://www.togami.com/~warren/archive/2003/fxa36-kernel-2.5.70.cfg
My kernel .config file.

Thanks,
Warren Togami
warren@togami.com
p.s. Please CC me in replies.

