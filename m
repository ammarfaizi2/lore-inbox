Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130910AbQKRB7c>; Fri, 17 Nov 2000 20:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131025AbQKRB7V>; Fri, 17 Nov 2000 20:59:21 -0500
Received: from slc815.modem.xmission.com ([166.70.6.53]:51209 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130910AbQKRB7M>; Fri, 17 Nov 2000 20:59:12 -0500
To: Daniel Phillips <phillips@innominate.de>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: Advanced Linux Kernel/Enterprise Linux Kernel
In-Reply-To: <200011141459.IAA413471@tomcat.admin.navo.hpc.mil> <3A117311.8DC02909@holly-springs.nc.us> <news2mail-3A15ACE3.5BED2CA3@innominate.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2000 17:58:58 -0700
In-Reply-To: Daniel Phillips's message of "Fri, 17 Nov 2000 23:10:43 +0100"
Message-ID: <m1u2965c4t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <news-innominate.list.linux.kernel@innominate.de> writes:

> Actually, I was planning on doing on putting in a hack to do something
> like that: calculate a checksum after every buffer data update and check
> it after write completion, to make sure nothing scribbled in the buffer
> in the interim.  This would also pick up some bad memory problems.

Be very careful that this just applies to metadata.  For normal data
this is a valid case.  Weird but valid.


Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
