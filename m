Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbUJZN54@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbUJZN54 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 09:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbUJZN54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 09:57:56 -0400
Received: from mx13.sac.fedex.com ([199.81.197.53]:19973 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S262268AbUJZN5o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 09:57:44 -0400
Date: Tue, 26 Oct 2004 21:55:38 +0800 (SGT)
From: Jeff Chua <jeffchua@silk.corp.fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: jfannin1@columbus.rr.com
cc: Christophe Saout <christophe@saout.de>,
       Mathieu Segaud <matt@minas-morgul.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alasdair G Kergon <agk@redhat.com>
Subject: Re: 2.6.9-mm1: LVM stopped working
In-Reply-To: <20041026123651.GA2987@zion.rivenstone.net>
Message-ID: <Pine.LNX.4.61.0410262152510.31267@silk.corp.fedex.com>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net>
 <20041026123651.GA2987@zion.rivenstone.net>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/26/2004
 09:57:27 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/26/2004
 09:57:38 PM,
	Serialize complete at 10/26/2004 09:57:38 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Oct 2004 jfannin1@columbus.rr.com wrote:

> On Mon, Oct 25, 2004 at 09:03:22PM +0200, Christophe Saout wrote:
>> Am Sonntag, den 24.10.2004, 01:06 +0200 schrieb Mathieu Segaud:
>>
>>> Well, I gave a try to last -mm tree. The bot seemed good till it got to
>>> LVM stuff. Vgchange does not find any volume groups. I can't say much because
>>> lvm is pretty "early stuff" on this box; so it is pretty unusable.
>
>    LVM doesn't work with 2.6.9-mm1 here either, complaining that it
> can't find all the pv's. I'm not using any sort of encryption. Here,
> pvdisplay reports:

It doesn't work on 2.6.10-rc1 either. Works fine on 2.6.9 and 2.4.8-rc1.

   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device
   striped: Required device-mapper target(s) not detected in your kernel
   lvcreate: Create a logical volume



Jeff.
