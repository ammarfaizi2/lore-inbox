Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265638AbTGIDWa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 23:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbTGIDWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 23:22:30 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:21128 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265638AbTGIDW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 23:22:28 -0400
Date: Tue, 8 Jul 2003 22:12:01 -0400
From: Ben Collins <bcollins@debian.org>
To: Zygo Blaxell <uixjjji1@umail.furryterror.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 IDE and IEEE1394+SBP2 regressions, orinoco_pci progress
Message-ID: <20030709021201.GH5830@phunnypharm.org>
References: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2003.07.08.22.25.12.249185.15455@umail.hungrycats.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The IEEE1394+SBP2 driver combination in 2.4.21 has problems.  When the
> kernel is compiled for single-processor the SBP2 driver can't log into my
> SBP2 devices and hangs rmmod when the module is removed--in other words,
> it's useless.  When compiled for SMP, the SBP2 driver works more or less
> normally, but still requires an IEEE1394 bus reset to work the second time
> a device is attached.  Note this is a laptop, so it only has one
> processor.

You did do rescan-scsi-bus.sh? What do you mean by "can't login"? Do you
mean it shows a login timeout, or that it doesn't even try? What does
/proc/bus/ieee1394/devices show?

Do I understand correctly that this is under cardbus?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
