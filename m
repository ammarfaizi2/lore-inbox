Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269951AbSISPNd>; Thu, 19 Sep 2002 11:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271162AbSISPNd>; Thu, 19 Sep 2002 11:13:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:33964 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269951AbSISPNb>;
	Thu, 19 Sep 2002 11:13:31 -0400
Date: Thu, 19 Sep 2002 12:13:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: axel@hh59.org
Cc: Andrew Morton <akpm@digeo.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.36-mm1
In-Reply-To: <20020919150959.GA1887@prester.hh59.org>
Message-ID: <Pine.LNX.4.44L.0209191212580.1519-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2002 axel@hh59.org wrote:

> Well. I have retrieved procps from CVS and built it. But then vmstat
> gets an segmentation fault. It looks like this..
>
> prester:/root# vmstat
>    procs                      memory      swap          io     system
> cpu
>  r  b  w   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy
> id
> Segmentation fault
> Exit 139

You made sure to run it with the _new_ libproc and not with
the old one you still have in /lib ?

Rik
-- 
Spamtrap of the month: september@surriel.com

http://www.surriel.com/		http://distro.conectiva.com/

