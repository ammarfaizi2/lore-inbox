Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbVGECs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbVGECs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 22:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVGECs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 22:48:58 -0400
Received: from mail.dvmed.net ([216.237.124.58]:10381 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261755AbVGECr1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 22:47:27 -0400
Message-ID: <42C9F4B9.7000805@pobox.com>
Date: Mon, 04 Jul 2005 22:47:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [git patches] IDE update
References: <Pine.GSO.4.62.0507031847460.678@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.GSO.4.62.0507031847460.678@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> Please pull from:
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git
> 
> diffstat+changelog below
> 
> Bartlomiej
> 
> 
>  drivers/ide/Makefile        |    1 -
>  drivers/ide/ide-lib.c       |   13 +++++--------
>  drivers/ide/pci/alim15x3.c  |   10 +++++-----
>  drivers/ide/pci/amd74xx.c   |    7 +++++--
>  drivers/ide/pci/cs5530.c    |    4 ++--
>  drivers/ide/pci/cy82c693.c  |    8 ++++----
>  drivers/ide/pci/it8172.c    |    4 ++--
>  drivers/ide/pci/ns87415.c   |    2 +-
>  drivers/ide/pci/opti621.c   |    2 +-
>  drivers/ide/pci/sc1200.c    |    2 +-
>  drivers/ide/pci/sl82c105.c  |    6 +++---
>  drivers/ide/pci/slc90e66.c  |    2 +-
>  drivers/ide/pci/triflex.c   |    2 +-
>  drivers/ide/pci/via82cxxx.c |    4 ++--
>  include/linux/pci_ids.h     |    1 +
>  15 files changed, 34 insertions(+), 34 deletions(-)

FWIW, we should encourage the janitors to submit patches larger than 
simply one patch per file.  Spreading the -same- logical change across 
multiple patches is really taking the "split it up" mantra too far.

We want logical changes separated...  but this just spams the log IMO.

All of the __devinit changes could have been rolled into a single patch, 
since its going to a single maintainer (Bart).

	Jeff



