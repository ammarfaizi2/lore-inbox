Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWFJI4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWFJI4B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWFJI4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:56:01 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:24269 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751416AbWFJI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:56:00 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Hui Zhou <hzhou@hzsolution.net>
Subject: Re: Frustrating Random Reboots, seeking suggestions
Date: Sat, 10 Jun 2006 10:52:03 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060609145757.GB1640@smtp.comcast.net> <Pine.LNX.4.64.0606091058320.4969@turbotaz.ourhouse> <20060610023719.GA10857@smtp.comcast.net>
In-Reply-To: <20060610023719.GA10857@smtp.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606101052.05212.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hui Zhou,

On Saturday, 10. June 2006 04:37, Hui Zhou wrote:
> Thanks. memtest86 passes 6 times without errors. Serial console didn't 
> show up anything (it just reboots). 
> 
> Anyway, I finally suspect the debian libmpeg binary is at fault. I 
> manually build it from src and statically linked to the `bkmark' 
> program. It seems cured the random reboots problem. It runs 
> successfully for 4 times. However, the fifth time it ended up in a `D' 
> state. The only system call it uses is libc file IO and some signal 
> passing. Any comment on the cause?

Do you also see the problem if you decode from file to memory only.
without any display?

NO: You have some problem with your peripherals.

YES: Check for heat and power problems.

	If you are brave you could try some cpuburn variant to put the heat 
	to the maximum.

	WARNING: This could kill your CPU and might void your warranty, 
		since this is not "normal use" of your CPU :-)

Good luck!


Regards

Ingo Oeser
