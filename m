Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313173AbSC1Ouc>; Thu, 28 Mar 2002 09:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313176AbSC1OuX>; Thu, 28 Mar 2002 09:50:23 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:20987 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S313172AbSC1OuG>; Thu, 28 Mar 2002 09:50:06 -0500
Message-ID: <3CA32D9D.1EF59C5E@redhat.com>
Date: Thu, 28 Mar 2002 14:50:05 +0000
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.51smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA2C68E.5B8C4176@zip.com.au> <Pine.GSO.4.21.0203280918190.24447-100000@weyl.math.psu.edu> <15523.10878.394037.864862@laputa.namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Explicit initialization always leaves room for some "pad" field inserted
> by compiler for alignment to be left with garbage. This is more than
> just annoyance when structure is something that will be written to the
> disk. Reiserfs had such problems.

such compiler-based padding is architecture specific.. I'd hope the
reiserfs
on disk format isn't architecture specific ?
