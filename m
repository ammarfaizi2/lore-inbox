Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbSKDS2P>; Mon, 4 Nov 2002 13:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262447AbSKDS2P>; Mon, 4 Nov 2002 13:28:15 -0500
Received: from [217.144.230.27] ([217.144.230.27]:42252 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S262408AbSKDS2O>;
	Mon, 4 Nov 2002 13:28:14 -0500
Date: Mon, 4 Nov 2002 19:34:47 +0100 (CET)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@lexx.infeline.org
To: Thomas Schenk <tschenk@origin.ea.com>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Need assistance in determining memory usage
In-Reply-To: <1036433472.2884.42.camel@shire>
Message-ID: <Pine.LNX.4.44.0211041931150.17060-100000@lexx.infeline.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2002, Thomas Schenk wrote:

> Q. How can you determine how much memory a process is using at a given
> point in time?  Specifically, I want to know of a method or tool that
> will tell me how much total memory a process is using, how much of that
> total is shared with other processes, how much is resident, and how much
> is swapped out.

/proc/<pid>/{stat,statm,status} are probably helpful. There's some info on
this in Documentation/filesystems/proc.txt

Ketil

