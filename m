Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280475AbRKFUKn>; Tue, 6 Nov 2001 15:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280460AbRKFUKd>; Tue, 6 Nov 2001 15:10:33 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:48278 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280475AbRKFUKU>; Tue, 6 Nov 2001 15:10:20 -0500
Date: Tue, 6 Nov 2001 15:10:16 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Dave Jones <davej@suse.de>
cc: Benjamin LaHaise <bcrl@redhat.com>,
        Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <Pine.LNX.4.30.0111062012580.5432-100000@Appserv.suse.de>
Message-ID: <Pine.GSO.4.33.0111061508280.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Dave Jones wrote:
>If this is done, it should perhaps be done on only on certain x86s,
>as some show the results go the other way. For example, the Cyrix III..

And for some (P150) it makes no difference...

read cr2 best: 25  av: 27.09
write cr2 cr2 best: 32  av: 34.39

read stk best: 26  av: 28.22
write cr2 stk best: 32  av: 33.04

--Ricky


