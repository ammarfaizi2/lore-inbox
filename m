Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbVGaCW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbVGaCW6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 22:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263200AbVGaCW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 22:22:57 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11164 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261538AbVGaCUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 22:20:49 -0400
To: linux-kernel@vger.kernel.org
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: ALSA, snd_intel8x0m and kexec() don't work together
 (2.6.13-rc3-git4 and 2.6.13-rc3-git3)
References: <20050721180621.GA25829@charite.de>
	<20050722062548.GJ25829@charite.de>
	<200507221614.28096.vda@ilport.com.ua>
	<20050722131825.GR8528@charite.de> <1122054941.877.6.camel@mindpipe>
	<20050722180204.GD30517@charite.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 30 Jul 2005 20:20:39 -0600
In-Reply-To: <20050722180204.GD30517@charite.de> (Ralf Hildebrandt's message
 of "Fri, 22 Jul 2005 20:02:04 +0200")
Message-ID: <m1br4j1zt4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt <Ralf.Hildebrandt@charite.de> writes:

> kexec is a system call that implements the ability to shutdown your
> current kernel, and to start another kernel.  It is like a reboot but it
> is indepedent of the system firmware.  And like a reboot you can start
> any kernel with it, not just Linux.
> 	  
> The name comes from the similiarity to the exec system call.
>
> It is an ongoing process to be certain the hardware in a machine is
> properly shutdown, so do not be surprised if this code does not initially
> work for you.  It may help to enable device hotplugging support.  As of
> this writing the exact hardware interface is strongly in flux, so no good
> recommendation can be made.

Hmm.  It looks like the text in Kconfig needs to be updated.
I don't think that description has been updated in several years.

Eric
