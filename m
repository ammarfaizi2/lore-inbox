Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbUJZOKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbUJZOKi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbUJZOKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:10:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262275AbUJZOKc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:10:32 -0400
Date: Tue, 26 Oct 2004 15:09:25 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: jfannin1@columbus.rr.com, Christophe Saout <christophe@saout.de>,
       Mathieu Segaud <matt@minas-morgul.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-mm1: LVM stopped working
Message-ID: <20041026140925.GO16193@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Jeff Chua <jeffchua@silk.corp.fedex.com>, jfannin1@columbus.rr.com,
	Christophe Saout <christophe@saout.de>,
	Mathieu Segaud <matt@minas-morgul.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <Pine.LNX.4.61.0410262152510.31267@silk.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410262152510.31267@silk.corp.fedex.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 09:55:38PM +0800, Jeff Chua wrote:
> It doesn't work on 2.6.10-rc1 either. Works fine on 2.6.9 and 2.4.8-rc1.
>   device-mapper ioctl cmd 0 failed: Inappropriate ioctl for device

Do you get any corresponding kernel messages?
Check /dev/mapper/control corresponds to  /proc/devices & /proc/misc.
(See device-mapper scripts/devmap_mknod.sh)
Use 'dmsetup version' and 'dmsetup targets' to test.

Alasdair
-- 
agk@redhat.com
