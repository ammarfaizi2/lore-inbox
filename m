Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWDRLEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDRLEp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWDRLEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:04:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:3968 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932179AbWDRLEo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:04:44 -0400
Subject: Re: [PATCH 1/1] ide: Allow disabling of UDMA for Compact Flash
	devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Ausmus <james.ausmus@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
References: <b79f23070604171611j784cc9afpd1bc6660cd25eed5@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 12:14:18 +0100
Message-Id: <1145358858.18736.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-04-17 at 16:11 -0700, James Ausmus wrote:
> Some IDE -> Compact Flash media adapters are not capable of supporting
> UDMA, which can cause very slow boot times when the CF media itself
> reports as capable of UDMA transfer speeds. Create Kconfig option to
> turn off the UDMA capability bit when media is identified as Compact
> Flash.

This would be far better if it was a boot time option than a kernel
configuration or set using sysfs/procfs controls as users will not want
to recompile their kernel in such cases.

