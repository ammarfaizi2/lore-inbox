Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132322AbQL2VuS>; Fri, 29 Dec 2000 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132422AbQL2VuJ>; Fri, 29 Dec 2000 16:50:09 -0500
Received: from [63.95.87.168] ([63.95.87.168]:48136 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S132322AbQL2Vty>;
	Fri, 29 Dec 2000 16:49:54 -0500
Date: Fri, 29 Dec 2000 16:19:28 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Rafal Boni <rafal.boni@eDial.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19pre3 and poor reponse to RT-scheduled processes?
Message-ID: <20001229161927.A560@xi.linuxpower.cx>
In-Reply-To: <200012292045.PAA17190@ninigret.metatel.office>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <200012292045.PAA17190@ninigret.metatel.office>; from rafal.boni@eDial.com on Fri, Dec 29, 2000 at 03:45:23PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 03:45:23PM -0500, Rafal Boni wrote:
[snip]
> 	The box in question is running the linux-ha.org heartbeat package,
> 	which is a RT-scheduled, mlock()'ed process, and as such should
> 	get as good service as the box is able to mange.  Often, under
> 	high disk (and/or MM) loads, the box becomes unreponsive for a
> 	period of time from ~ 1 sec to a high of ~ 2.8sec.
[snip]

You are running IDE aren't you?

Enable DMA and/or unmask interupts.

man hdparm

Good luck.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
