Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131578AbRDCKUr>; Tue, 3 Apr 2001 06:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRDCKUg>; Tue, 3 Apr 2001 06:20:36 -0400
Received: from fs1.dekanat.physik.uni-tuebingen.de ([134.2.216.20]:17156 "EHLO
	fs1.dekanat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id <S131158AbRDCKUS>; Tue, 3 Apr 2001 06:20:18 -0400
Date: Tue, 3 Apr 2001 12:09:27 +0200 (CEST)
From: Richard Guenther <richard.guenther@student.uni-tuebingen.de>
To: Gustavo Niemeyer <niemeyer@conectiva.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: pthreads & fork & execve
In-Reply-To: <20010402095425.A15554@tux.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0104031207480.15603-100000@fs1.dekanat.physik.uni-tuebingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Apr 2001, Gustavo Niemeyer wrote:

> Hi Richard! Hi Dennis!
[...]

> Btw, both are mainly C++ programs. Is your software written in C++?

Not, just plain C - but one point is that we started seeing the problem
after we started using pthread_sigmask() to block certain signals from
reaching our threads.

Richard.

--
Richard Guenther <richard.guenther@uni-tuebingen.de>
WWW: http://www.tat.physik.uni-tuebingen.de/~rguenth/
The GLAME Project: http://www.glame.de/

