Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281832AbRKRAJ7>; Sat, 17 Nov 2001 19:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281833AbRKRAJj>; Sat, 17 Nov 2001 19:09:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30602 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281832AbRKRAJ1>;
	Sat, 17 Nov 2001 19:09:27 -0500
Date: Sat, 17 Nov 2001 19:09:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: hari <harisri@bigpond.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.15-pre5 - probably something wrong with /proc/cpuinfo.
In-Reply-To: <20011118000346Z281221-17408+15574@vger.kernel.org>
Message-ID: <Pine.GSO.4.21.0111171907190.11475-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Nov 2001, hari wrote:

> On a related note redirecting the contents of /proc/cpuinfo using 'cat' 
> command to a file on my home directory and providing that as an input fixes 
> the problem. For eg:

Eww...  If anything, that's cat </proc/cpuinfo | while ...,
but that's quite ugly.  Try the patch I've posted on l-k
(Subject: [PATCH][CFT] seq_file and lseek).

