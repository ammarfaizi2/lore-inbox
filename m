Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbSJOTre>; Tue, 15 Oct 2002 15:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbSJOTrd>; Tue, 15 Oct 2002 15:47:33 -0400
Received: from viefep16-int.chello.at ([213.46.255.17]:51748 "EHLO
	viefep16-int.chello.at") by vger.kernel.org with ESMTP
	id <S264641AbSJOTr2>; Tue, 15 Oct 2002 15:47:28 -0400
From: Simon Roscic <simon.roscic@chello.at>
To: Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [Kernel 2.5] Qlogic 2x00 driver
Date: Tue, 15 Oct 2002 21:53:08 +0200
User-Agent: KMail/1.4.7
References: <200210152120.13666.simon.roscic@chello.at> <1034710299.1654.4.camel@localhost.localdomain>
In-Reply-To: <1034710299.1654.4.camel@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210152153.08603.simon.roscic@chello.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 October 2002 21:31, Arjan van de Ven <arjanv@redhat.com> wrote:
> Oh so you haven't notices how it buffer-overflows the kernel stack, how
> it has major stack hog issues, how it keeps the io request lock (and
> interrupts disabled) for a WEEK ?

doesn't sound good, ...
as i said, i don't have any problems (= failures, data loss, etc.) with this driver, 
sounds like i should update to a newer driver version, wich qlogic 2x00 driver 
version do you recommend ?   or does this affect all versions of this driver ?

(performance on the machines i use is quite good, a dbench 256 gave me
approx. 60 mb/s (ibm xseries 342, 1x pentium 3 - 1,2 ghz, 512 - 1024 mb ram))

arjan, thanks for the info, i didn't notice that the driver was that bad,
i had much to do in the past months, so i possibly missed disscussions
about the qlogic2x00 stuff, sorry,

simon.
(please CC me, i'm not subscribed to lkml)
