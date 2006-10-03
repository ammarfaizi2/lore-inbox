Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965068AbWJCEMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWJCEMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWJCEMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:12:22 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:27360
	"EHLO saville.com") by vger.kernel.org with ESMTP id S932339AbWJCEMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:12:21 -0400
Message-ID: <4521E326.2000406@saville.com>
Date: Mon, 02 Oct 2006 21:12:22 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Matthias Hentges <oe@hentges.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
 2.6.18 kernel
References: <45206777.7020405@saville.com> <1159808447.4652.6.camel@mhcln03>
In-Reply-To: <1159808447.4652.6.camel@mhcln03>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias,

Thanks, I tried your config file on 2.6.18 and it works!

The first time I tried my command line was:

Command line: root=/dev/sda2 ro quiet splash initcall_debug 
console=ttyS0,115200n8 loglevel=7 video=nvidiafb:nomtrr

and it came up but no keyboard or mouse, I changed it too:

Command line: root=/dev/sda2 ro quiet splash

You mentioned you "saw some hangs", I assume with the current 
configuration your having no problems with stability?

Thanks again,

Wink

