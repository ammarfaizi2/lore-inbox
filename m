Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTGAFdj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 01:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265976AbTGAFdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 01:33:39 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:4598 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S264399AbTGAFco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 01:32:44 -0400
Subject: Re: [PATCH] remove IO APIC newline
From: Martin Schlemmer <azarah@gentoo.org>
To: Diego Calleja =?ISO-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Jeff Garzik <jgarzik@pobox.com>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030627205742.48f107c2.diegocg@teleline.es>
References: <200306271836.h5RIakGD026159@hera.kernel.org>
	 <20030627184111.GB4333@gtf.org>
	 <20030627205742.48f107c2.diegocg@teleline.es>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1057039383.5499.46.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 01 Jul 2003 08:03:04 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 20:57, Diego Calleja García wrote:

> I did a patch wich makes dmesg output of SMP machines better. Well, it doesn't
> adds or removes any line; but it says "CPUX:". The patch ugly, basically
> it adds smp_processor_id() output in every printk i found. I did it because
> IMHO messages like "Intel machine check architecture supported" in a SMP machine
> are ugly. I'd found it specially nice for big SMP boxes because this does dmesg
> easily grep'able.
> 
> 
> -Initializing CPU#0
> +CPU0: Initializing
> [...]
> -Calibrating delay loop... 1602.35 BogoMIPS
> +CPU0: Calibrating delay loop... 1602.35 BogoMIPS
> [...]

Wont it be more consistant to rather use CPU#0, CPU#1, etc ?


Regards,

-- 
Martin Schlemmer


