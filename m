Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWCHDXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWCHDXf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCHDXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:23:35 -0500
Received: from rtr.ca ([64.26.128.89]:53135 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S932422AbWCHDXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:23:34 -0500
Message-ID: <440E4E30.409@rtr.ca>
Date: Tue, 07 Mar 2006 22:23:28 -0500
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8) Gecko/20060305 SeaMonkey/1.1a
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Mark Lord <liml@rtr.ca>,
       Bill Davidsen <davidsen@tmr.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>, axboe@suse.de,
       albertcc@tw.ibm.com
Subject: Re: LibPATA code issues / 2.6.15.4
References: <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046013.7070503@rtr.ca> <4404BAD6.3060009@tmr.com> <440E4803.7070808@rtr.ca> <20060308031829.GB5411@redhat.com>
In-Reply-To: <20060308031829.GB5411@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>
> looks like our userspace includes aren't up to date with some of the kernel
> changes, so currently they're lacking the ide_task_request_t and related
> taskfile bits.
> 
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=184349

Ahh.. Thanks, Dave.

hdparm-6.6 being released *now*, with that stuff #ifdef'd out when
the necessary header structs are missing.

It builds/runs for me, on RHEL4 at least.

Cheers
