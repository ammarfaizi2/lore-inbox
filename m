Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966593AbWKTTtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966593AbWKTTtr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966590AbWKTTtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:49:47 -0500
Received: from mx.laposte.net ([81.255.54.11]:30667 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S966584AbWKTTtp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:49:45 -0500
Subject: Re: Problem booting linux 2.6.19-rc5, 2.6.19-rc5-git6,     
	2.6.19-rc5-mm2 with md raid 1 over lvm root
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
       neilb@cse.unsw.edu.au, mingo@redhat.com, dm-devel@redhat.com
In-Reply-To: <456202FF.8060709@tmr.com>
References: <41884.81.64.156.37.1163631254.squirrel@rousalka.dyndns.org>
	 <455BB01B.2080309@gmail.com>  <456202FF.8060709@tmr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Organization: Adresse perso
Date: Mon, 20 Nov 2006 20:47:26 +0100
Message-Id: <1164052047.3004.25.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.2 (2.9.2-2.fc7) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 20 novembre 2006 à 14:33 -0500, Bill Davidsen a écrit :
> Tejun Heo wrote:

> >> I'm attaching the dmesg for the working distro kernel (yes I know not 
> >> 100%
> >> distro kernel, but very close to one), distro config , and the config I
> >> used in my test. If anyone could help me to figure what's wrong I'd be
> >> grateful.
> >
> > Say 'y' not 'm' to SCSI disk support.
> >
> That will probably work, but just building a new initrd is probably a 
> lot easier. Although I thought the SCSI modules were included if built 
> and installed if present.

Absolutely no idea why the inird-ing works on distro kernels but not
this one. Probably confused by the full-sata config

Regards,

-- 
Nicolas Mailhot
