Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266812AbRGFTZk>; Fri, 6 Jul 2001 15:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266814AbRGFTZa>; Fri, 6 Jul 2001 15:25:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:29957 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266812AbRGFTZK>; Fri, 6 Jul 2001 15:25:10 -0400
Date: Fri, 6 Jul 2001 16:24:52 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Sasha Pachev <sasha@mysql.com>
Cc: Mike Kravetz <mkravetz@sequent.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Strange thread behaviour on 8-way x86 machine
In-Reply-To: <0107061245200U.17811@mysql>
Message-ID: <Pine.LNX.4.33L.0107061624370.17825-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2001, Sasha Pachev wrote:

> Upon further investigation and testing, it turned out that the kernel was not
> at fault - the problem was high mutex contention, which caused frequent
> context switches, and the idle CPU was apparently from the scheduler waiting
> for the original CPU to become available too often.
>
> On a side note, it would be nice if a process could communicate
> to the kernel that it would rather run on the first available
> CPU than wait for the perfect one to become available.

The kernel already does this.

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

