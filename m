Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131590AbRCOFFO>; Thu, 15 Mar 2001 00:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRCOFE4>; Thu, 15 Mar 2001 00:04:56 -0500
Received: from [210.74.191.34] ([210.74.191.34]:5621 "EHLO
	bfrey.turbolinux.com.cn") by vger.kernel.org with ESMTP
	id <S131554AbRCOFEx>; Thu, 15 Mar 2001 00:04:53 -0500
Date: Thu, 15 Mar 2001 13:06:41 +0800
From: Bob Frey <bfrey@turbolinux.com.cn>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: dledford@redhat.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: scsi_scan problem.
Message-ID: <20010315130641.A14138@bfrey.dev.cn.tlan>
In-Reply-To: <3AB028BE.E8940EE6@redhat.com> <20010314213543.A30816@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010314213543.A30816@devserv.devel.redhat.com>; from zaitcev@redhat.com on Wed, Mar 14, 2001 at 09:35:43PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2001 at 09:35:43PM -0500, Pete Zaitcev wrote:
> 16384 LUNs for Fibre Channel. As you see, scanning is out of the
> question. You must issue REPORT LUNs and fall back on scanning
> if the device reports a check condition. I did that when I worked
Why wait for a check condition? There's an INQUIRY field bit that
indicates whether REPORT LUNs is supported.

-- 
Bob Frey
bfrey@turbolinux.com.cn
