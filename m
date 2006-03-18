Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbWCRJDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbWCRJDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWCRJDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:03:46 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:17101
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S932332AbWCRJDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:03:45 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Core on Linux questions
Date: Sat, 18 Mar 2006 03:03:40 -0600
Message-Id: <20060318085954.M66389@linuxwireless.org>
In-Reply-To: <441BCBAE.2020302@garzik.org>
References: <20060318082434.M33432@linuxwireless.org> <441BCBAE.2020302@garzik.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 200.91.94.134 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Mar 2006 03:58:22 -0500, Jeff Garzik wrote
> Alejandro Bonilla wrote:
> > Hi,
> > 
> > I have a few questions about the PM Dual Core and how could it really work
> > with Linux. Sorry if there are new patches on LKML about any of these things:
> > 
> > Could each processor or die, have it's own cpufreq scaling governor?
> 
> Sure.  On a laptop, if you don't need dual core power, it makes 
> sense to turn off the unused core, even.
> 
> 	Jeff

Jeff,

For some reason, while I was writing this email, I knew you would be the first
to reply. LOL. Anyway. Does this need new patches sent to LKML or nice
commands to make this work or any idea if stock cpufreqd should manage the
cores separatelly? I haven't got that to work on 2.6.15 so far. How flexible
can we get with the cores?

Thanks for your time,

.Alejandro
