Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbUCQAdO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261898AbUCQAdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 19:33:14 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:50598 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261874AbUCQAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 19:33:11 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Karol Kozimor <sziwan@hell.org.pl>
Subject: Re: [ACPI] X86_PM_TIMER: /proc/cpuinfo doesn't get updated
Date: Tue, 16 Mar 2004 19:33:07 -0500
User-Agent: KMail/1.6.1
Cc: john stultz <johnstul@us.ibm.com>, Dominik Brodowski <linux@brodo.de>,
       acpi-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
References: <20040316182257.GA2734@dreamland.darkstar.lan> <1079479694.5408.47.camel@cog.beaverton.ibm.com> <20040317001324.GA19180@hell.org.pl>
In-Reply-To: <20040317001324.GA19180@hell.org.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403161933.07816.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 07:13 pm, Karol Kozimor wrote:
> Thus wrote john stultz:
> > Hmm. This is untested, but I think this should do the trick.
> 
> Hmm... without the patch, neither cpu MHz nor bogomips are updated, with
> the patch cpu MHz value seems correct (both using acpi.ko and
> speedstep-ich.ko, but the bogomips is still at its initial value.
> Best regards,
> 

Karol, do you have a P4? AFAIK P4's TSC is stable even if core frequence
changes so loop_per_juffy (== bogomips) need not be updated.

-- 
Dmitry
