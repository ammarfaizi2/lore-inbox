Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWBUWzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWBUWzJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWBUWzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:55:08 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:28854 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964888AbWBUWzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:55:07 -0500
Subject: Re: Writing to an NFS share truncates files on >8Tb Raid + LVM2
From: Lee Revell <rlrevell@joe-job.com>
To: Ramon van Alteren <ramon@vanalteren.nl>
Cc: linux-kernel@vger.kernel.org, ramon@hyves.nl
In-Reply-To: <43FB3208.7020303@vanalteren.nl>
References: <43FB3208.7020303@vanalteren.nl>
Content-Type: text/plain
Date: Tue, 21 Feb 2006 17:55:02 -0500
Message-Id: <1140562502.2742.99.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-21 at 16:30 +0100, Ramon van Alteren wrote:
> I've so far found this:
> http://lwn.net/Articles/150580/
> 
> Which seems to indicate that RAID + LVM + complex storage and
> 4KSTACKS can cause problems. However I can't find the 4KSTACK symbol
> anywhere in my config. Can't find the 8KSTACK symbol anywhere
> either :-(
> 

Not likely to be your problem - 4KSTACKS depends on DEBUG_KERNEL which
you do not have enabled.

Lee

