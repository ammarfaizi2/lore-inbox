Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRCNMH7>; Wed, 14 Mar 2001 07:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRCNMHt>; Wed, 14 Mar 2001 07:07:49 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:5373 "HELO
	burns.conectiva") by vger.kernel.org with SMTP id <S131076AbRCNMHh>;
	Wed, 14 Mar 2001 07:07:37 -0500
Date: Wed, 14 Mar 2001 16:19:42 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: george anzinger <george@mvista.com>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, <npsimons@fsmlabs.com>,
        Guennadi Liakhovetski <g.liakhovetski@ragingbull.com>,
        Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: system call for process information?
In-Reply-To: <3AAF2AB6.6E9E53F4@mvista.com>
Message-ID: <Pine.LNX.4.33.0103141618320.21132-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Mar 2001, george anzinger wrote:

> Is it REALLY necessary to prevent them from seeing an
> inconsistent state?  Seems to me that in the total picture (i.e.
> system wide) they will never see a consistent state, so why be
> concerned with a small corner of the system.

You're right. All we need to make sure of is that the address
space we want to print info about doesn't go away while we're
reading the stats ...

(I think ... but we'll need to look at the procfs code in more
detail)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

