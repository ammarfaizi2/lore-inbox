Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbRHFI4k>; Mon, 6 Aug 2001 04:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbRHFI4a>; Mon, 6 Aug 2001 04:56:30 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14859 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S267500AbRHFI4Y>; Mon, 6 Aug 2001 04:56:24 -0400
Message-ID: <3B6E5B73.2DAEBBD5@idb.hist.no>
Date: Mon, 06 Aug 2001 10:55:15 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.8-pre4 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Stephen Satchell <satch@fluent-access.com>, linux-kernel@vger.kernel.org
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com> <4.3.2.7.2.20010803225855.00bc2a60@mail.fluent-access.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Satchell wrote:

> While the idea halts other programs trying to allocate memory, it would
> provide cycles to programs that want to RELEASE memory (such as consuming
> data in network buffers) and thus reduce the kswapd thumb-twiddling time.

Processes that want to use much memory on a heavily swapping machine 
get delayed already - they have to wait for the swapping.  This leaves
the cpu free to do other things, such as running those nice programs
that use little memory or even frees up some.

Helge Hafting
