Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262856AbSJASO7>; Tue, 1 Oct 2002 14:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262857AbSJASO6>; Tue, 1 Oct 2002 14:14:58 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:6730 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S262856AbSJASO5> convert rfc822-to-8bit;
	Tue, 1 Oct 2002 14:14:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Organization: -ENOENT
To: Daniel Phillips <phillips@arcor.de>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: qsbench, interesting results
Date: Tue, 1 Oct 2002 20:18:56 +0200
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0210011348060.653-100000@duckman.distro.conectiva> <E17wQQv-0005vB-00@starship>
In-Reply-To: <E17wQQv-0005vB-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210012018.56145.l.allegrucci@tiscalinet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 19:03, Daniel Phillips wrote:
> On Tuesday 01 October 2002 18:52, Rik van Riel wrote:
> > Having the working set of one process larger than RAM is
> > a highly unusual case ...
>
> No it's not, it's very similar to having several processes active whose
> working sets add up to more than RAM.

qsbench has a "-p" option to distribute the load on multiple
processes.
I think the actual code is too trivial to simulate a realistic
multithreaded workload, but it might be improved..

