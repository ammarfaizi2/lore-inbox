Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266750AbSLJLZi>; Tue, 10 Dec 2002 06:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266761AbSLJLZi>; Tue, 10 Dec 2002 06:25:38 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:59101 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266750AbSLJLZh>; Tue, 10 Dec 2002 06:25:37 -0500
Cc: linux-kernel@vger.kernel.org
References: <20021210032242.GA17583@net-ronin.org>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: carbonated beverage <ramune@net-ronin.org>
Subject: Re: capable open_port() check wrong for kmem
Date: Tue, 10 Dec 2002 12:33:04 +0100
Message-ID: <87fzt6nm6n.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

carbonated beverage <ramune@net-ronin.org> writes:

> 	I found that I can't open /dev/kmem O_RDONLY.  The open_mem
> and open_kmem calls (open_port()) in drivers/char/mem.c checks for
> CAP_SYS_RAWIO.
>
> 	Is there a possibility of splitting that off into a read and
> write pair, i.e. CAP_SYS_RAWIO_WRITE, CAP_SYS_RAWIO_READ?
>
> 	If not, is there a way to grant read-only access to /dev/kmem?

You may want to look at this thread:
<http://groups.google.com/groups?threadm=87smza1p7f.fsf%40goat.bogus.local>

Regards, Olaf.
