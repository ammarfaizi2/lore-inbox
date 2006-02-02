Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWBBVFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWBBVFr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 16:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWBBVFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 16:05:46 -0500
Received: from khc.piap.pl ([195.187.100.11]:7692 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932243AbWBBVFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 16:05:46 -0500
To: Bill Davidsen <davidsen@tmr.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
References: <43DEA195.1080609@tmr.com> <20060201210433.GC8552@ucw.cz>
	<43E2602C.2090008@tmr.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 02 Feb 2006 22:05:41 +0100
In-Reply-To: <43E2602C.2090008@tmr.com> (Bill Davidsen's message of "Thu, 02 Feb 2006 14:40:28 -0500")
Message-ID: <m3ek2l31zu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> writes:

> The question is still why not make all devices look like SCSI, and use
> one set of drivers and a bit of glue.

That could probably make sense, and libata currently does that (which,
I hope, will obsolete drivers/ide WRT PATA as well), but SCSI commands
are a different thing than a bus/ID/lun address from outer space.
-- 
Krzysztof Halasa
