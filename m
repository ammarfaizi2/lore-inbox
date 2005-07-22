Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVGVRzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVGVRzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 13:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGVRzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 13:55:45 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:17026 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262123AbVGVRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 13:55:43 -0400
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together
	(2.6.13-rc3-git4 and 2.6.13-rc3-git3)
From: Lee Revell <rlrevell@joe-job.com>
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050722131825.GR8528@charite.de>
References: <20050721180621.GA25829@charite.de>
	 <20050722062548.GJ25829@charite.de> <200507221614.28096.vda@ilport.com.ua>
	 <20050722131825.GR8528@charite.de>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 13:55:41 -0400
Message-Id: <1122054941.877.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 15:18 +0200, Ralf Hildebrandt wrote:
> * Denis Vlasenko <vda@ilport.com.ua>:
> 
> > Not happening here on 2.6.12:
> 
> 2.6.12 didn't have kexec (unless it's a -mm kernel)
> So how could you boot using kexec then?
> 

Is kexec supposed to be transparent to all the subsystems, or does ALSA
have to know how to stop all DMA in order for kexec to work?

Lee

