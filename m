Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267684AbTAaN2N>; Fri, 31 Jan 2003 08:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267737AbTAaN2N>; Fri, 31 Jan 2003 08:28:13 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:46773 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267684AbTAaN2N>; Fri, 31 Jan 2003 08:28:13 -0500
Message-ID: <3E3A7C22.1080709@namesys.com>
Date: Fri, 31 Jan 2003 16:37:38 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] ext3, reiser, jfs, xfs effect on contest
References: <200302010020.34119.conman@kolivas.net>
In-Reply-To: <200302010020.34119.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Be sure to create the tar on the same filesystem that you unpack it onto 
--- readdir order affects performance.

A result that we are faster for writes and slower for reads for 
workloads without large directories or small files is believable.

compilation is not an effective benchmark anymore, not for Linux 
filesystems, they are all just too fast (or is it that the compilers are 
too slow?....)

I don't know what ioload does....

-- 
Hans


