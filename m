Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbVJSDoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbVJSDoW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJSDoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:44:22 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:14723 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932395AbVJSDoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:44:22 -0400
Subject: Re: scsi_eh / 1394 bug - -rt7
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
References: <5bdc1c8b0510181402o2d9badb0sd18012cf7ff2a329@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 23:43:43 -0400
Message-Id: <1129693423.8910.54.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 14:02 -0700, Mark Knecht wrote:
> Hi,
>    I'm seeing this each time I plug in a 1394 hard drive:
> 
> Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
> ieee1394: Node changed: 0-01:1023 -> 0-00:1023
> ieee1394: Node changed: 0-02:1023 -> 0-01:1023
> ieee1394: Reconnected to SBP-2 device
> ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
> ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00b31ec]
> prev->state: 2 != TASK_RUNNING??
> scsi_eh_6/20286[CPU#0]: BUG in __schedule at kernel/sched.c:3328

I hit this exact same bug while at a client site today, with an external
USB drive. 

Lee

