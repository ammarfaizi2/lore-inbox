Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271710AbRHQReT>; Fri, 17 Aug 2001 13:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271705AbRHQReK>; Fri, 17 Aug 2001 13:34:10 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2059 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271709AbRHQRdz>; Fri, 17 Aug 2001 13:33:55 -0400
Date: Fri, 17 Aug 2001 14:34:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Eduardo =?iso-8859-1?q?Cort=E9s=20?= <the_beast@softhome.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Re: limit cpu
In-Reply-To: <20010816162913Z271588-760+2494@vger.kernel.org>
Message-ID: <Pine.LNX.4.33L.0108171432320.2277-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Eduardo Cortés  wrote:

> I think that it's a good feature for linux, but I don't know if
> is very complex to develope in linux. If I can limit the max cpu
> usage (in %) for an user/group, the box is more solid.

Conectiva has been shipping a patch to limit CPU usage
on a per-user basis in their 2.2 kernel RPM for quite
a while now.

Unfortunately I ran into problems with ksoftirqd while
porting the patch to 2.4 and have been tied up in the
memory management and other projects since.

Oh, the patch also doesn't have any effect on the scheduler
fast-path. Only the recalculation is changed...

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

