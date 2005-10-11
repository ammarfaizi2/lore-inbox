Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVJKO7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVJKO7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVJKO7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:59:21 -0400
Received: from qproxy.gmail.com ([72.14.204.197]:3984 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932117AbVJKO7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:59:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=h+aVkgC5s6gDzkQe3oEpDpFcBAMINDMiOg+UcHhxkXL8G668hqbf+GujdbC6bl3FdTuH/EIlrKDU7rwgJTH+rJ2BFz+HFeh8lH9soEeCX+VrseFQjmUnAYTemELURgze17ilX3v0ZYfHTJpIQbiD+zpN1W6QX9//Re9woFDh7xQ=
Message-ID: <6bffcb0e0510110759h1c6c2082v@mail.gmail.com>
Date: Tue, 11 Oct 2005 14:59:19 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-rc3-git-current IDE disc problem
Cc: bzolnier@gmail.com
In-Reply-To: <6bffcb0e0510091300q58e6cf76y@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6bffcb0e0510091300q58e6cf76y@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
it looks similar.

hdd: LITE-ON LTR-52327S, ATAPI CD/DVD-ROM drive
Badness in enable_irq at kernel/irq/manage.c:113
 [<c013f523>] enable_irq+0x6f/0xc4
 [<f885c7c3>] probe_hwif+0x3f6/0x4dc [ide_core]
 [<c0115f5b>] try_to_wake_up+0x69/0x353
 [<f885d59a>] ideprobe_init+0x66/0x145 [ide_core]
 [<f88b2005>] ide_generic_init+0x5/0xd [ide_generic]
 [<c0138346>] sys_init_module+0xc5/0x221
 [<c0102e1f>] sysenter_past_esp+0x54/0x75
register_blkdev: cannot get major 3 for ide0
register_blkdev: cannot get major 22 for ide1

debian:/home/michal# uname -r
2.6.14-rc3-gdd0fc66f

Regards,
Michal Piotrowski
