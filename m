Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCPOmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCPOmi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 09:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWCPOmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 09:42:38 -0500
Received: from boogie.lpds.sztaki.hu ([193.225.12.226]:57306 "EHLO
	boogie.lpds.sztaki.hu") by vger.kernel.org with ESMTP
	id S1751145AbWCPOmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 09:42:38 -0500
Date: Thu, 16 Mar 2006 15:42:26 +0100
From: Gabor Gombas <gombasg@sztaki.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>,
       Allen Martin <AMartin@nvidia.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060316144226.GV15509@boogie.lpds.sztaki.hu>
References: <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu> <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu> <44189A3D.5090202@garzik.org> <20060315231426.GD17817@ti64.telemetry-investments.com> <20060316031528.GF17817@ti64.telemetry-investments.com> <1142482825.1671.148.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142482825.1671.148.camel@mindpipe>
X-Copyright: Forwarding or publishing without permission is prohibited.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 11:20:24PM -0500, Lee Revell wrote:

> Lots of people have these boards and it seems like if the problem was
> widespread, I would have seen it on the Linux audio lists, as many of
> those users run Ingo's instrumented kernel and they all know to report
> latency traces when they get them.

I did not experience any sata_nv problems with 2 disks/RAID1 (at least I
never noticed). I immediately got the "warning: many lost ticks. Your
time source seems to be instable or some driver is hogging interupts"
message when I started using 4 disks/RAID5. It's possible that most
people do not have enough disks connected to the nForce4 to trigger the
bug.

Gabor

-- 
     ---------------------------------------------------------
     MTA SZTAKI Computer and Automation Research Institute
                Hungarian Academy of Sciences
     ---------------------------------------------------------
