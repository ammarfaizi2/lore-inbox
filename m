Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266876AbTAaNbs>; Fri, 31 Jan 2003 08:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTAaNbs>; Fri, 31 Jan 2003 08:31:48 -0500
Received: from mail020.syd.optusnet.com.au ([210.49.20.135]:53892 "EHLO
	mail020.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S266876AbTAaNbr> convert rfc822-to-8bit; Fri, 31 Jan 2003 08:31:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
Date: Sat, 1 Feb 2003 00:40:49 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200302010020.34119.conman@kolivas.net> <3E3A7C22.1080709@namesys.com>
In-Reply-To: <3E3A7C22.1080709@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302010040.49141.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 Feb 2003 12:37 am, Hans Reiser wrote:
> Be sure to create the tar on the same filesystem that you unpack it onto
> --- readdir order affects performance.

The tar creation is on the same filesystem as the unpacking

>
> A result that we are faster for writes and slower for reads for
> workloads without large directories or small files is believable.
>
> compilation is not an effective benchmark anymore, not for Linux
> filesystems, they are all just too fast (or is it that the compilers are
> too slow?....)
>
> I don't know what ioload does....

io load simply repeatedly writes a 256Mb file to the same filesystem as the 
compilation is occurring in. io_other writes the 256Mb file to a different 
hard disk containing the filesystem in question.

Con
