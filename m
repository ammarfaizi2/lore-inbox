Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSLJWos>; Tue, 10 Dec 2002 17:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbSLJWos>; Tue, 10 Dec 2002 17:44:48 -0500
Received: from spacecake.plus.com ([195.166.148.239]:12160 "EHLO
	unicorn.encapsulated.net") by vger.kernel.org with ESMTP
	id <S265567AbSLJWor>; Tue, 10 Dec 2002 17:44:47 -0500
Date: Tue, 10 Dec 2002 22:46:14 +0000
From: Spacecake <lkml@spacecake.plus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sflory@rackable.com, linux-kernel@vger.kernel.org
Subject: Re: HPT372 RAID controller
Message-Id: <20021210224614.1d175371.lkml@spacecake.plus.com>
In-Reply-To: <1039553984.14302.65.camel@irongate.swansea.linux.org.uk>
References: <20021208123134.4be342c7.lkml@spacecake.plus.com>
	<3DF4E433.5010207@rackable.com>
	<20021209203338.32e8665f.lkml@spacecake.plus.com>
	<1039480307.12051.8.camel@irongate.swansea.linux.org.uk>
	<20021210180931.0b174cd5.lkml@spacecake.plus.com>
	<1039553984.14302.65.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the same occur without taskfile I/O ?

I just tried it... copying the exact same files across from the exact
same hdd etc. It didn't crash my system this time, and the files seem
okay. However - there were long pauses where CPU load was so high that X
wouldn't update the screen for about 10 seconds at a time, and things
were acting slightly weird for a few seconds after i got back my prompt.
And now the HDD light is on permanently whether i have disk access or
not. Hmm.
Though this *could* be a coincidence.
