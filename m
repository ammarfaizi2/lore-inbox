Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293490AbSBZCZe>; Mon, 25 Feb 2002 21:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293493AbSBZCZX>; Mon, 25 Feb 2002 21:25:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42249 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293490AbSBZCZS>; Mon, 25 Feb 2002 21:25:18 -0500
Subject: Re: Submissions for 2.4.19-pre [sdmany (Richard Gooch)] [Discuss :) ]
To: me@ohdarn.net (Michael Cohen)
Date: Tue, 26 Feb 2002 02:40:02 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20020225204125.72b2289f.me@ohdarn.net> from "Michael Cohen" at Feb 25, 2002 08:41:25 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fXX8-0007Tn-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +CONFIG_SD_MANY
> +  This allows you to support a very large number of SCSI discs
> +  (approximately 2080). You will also need to set CONFIG_DEVFS_FS=y
> +  later. This option may consume all unassigned block majors

As discussed before - this is a bad idea. Please don't regurgitate random
incorrect patches - it doesnt help. For 2.4 there is no clean way to do 
this for 2.5 driverfs and a 32bit dev_t gets you there for free and done
right
