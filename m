Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262533AbVDLWOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262533AbVDLWOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbVDLWKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 18:10:48 -0400
Received: from smtp06.auna.com ([62.81.186.16]:7094 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S263017AbVDLWIf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 18:08:35 -0400
Date: Tue, 12 Apr 2005 22:08:23 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: What does 'WrongLevel' mean in RAID0 ?
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1113338725l.7969l.0l@werewolf.able.es>
	<16988.17389.81020.101830@cse.unsw.edu.au>
In-Reply-To: <16988.17389.81020.101830@cse.unsw.edu.au> (from
	neilb@cse.unsw.edu.au on Tue Apr 12 23:55:57 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1113343703l.9659l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.12, Neil Brown wrote:
> On Tuesday April 12, jamagallon@able.es wrote:
> > Hi all...
> > 
> > I have a RAID0 setup on top of three IDE drives.
> > mdadm monitor sends me mesages with:
> > 
> > DeviceDisappeared
> > /dev/md0
> > Wrong-Level
> > 
> > The RAID seems to be working well. Any pointer on what does this
> > mean ?
> 
>  From  "man mdadm"  (if you know where to look)
> 
>        Follow or Monitor
>               Monitor  one  or  more  md devices and act on any state changes.
>               This is only meaningful for raid1, 4, 5, 6 or  multipath  arrays
>               as  only  these  have  interesting state.  raid0 or linear never
>               have missing, spare, or failed drives, so there  is  nothing  to
>               monitor.
> 
> You are presumably trying to monitor a raid0 (which isn't meaningful)
> and mdadm is telling you (in its own idiosyncratic way) that it isn't
> going to monitor it.
> 

Thank you very much !! One less mistery in my life ;)

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Limited Edition 2005) for i586
Linux 2.6.11-jam14 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-7mdk)) #3


