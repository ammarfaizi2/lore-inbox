Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288557AbSBRWTs>; Mon, 18 Feb 2002 17:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288485AbSBRWTj>; Mon, 18 Feb 2002 17:19:39 -0500
Received: from 162-39.84.64.covalent.net ([64.84.39.162]:7475 "EHLO
	doom.sfo.covalent.net") by vger.kernel.org with ESMTP
	id <S288325AbSBRWT1>; Mon, 18 Feb 2002 17:19:27 -0500
Date: Mon, 18 Feb 2002 14:19:20 -0800
From: john <john@zlilo.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: john <john@zlilo.com>, linux-kernel@vger.kernel.org
Subject: Re: kupdated using all CPU
Message-ID: <20020218141920.D2586@doom.sfo.covalent.net>
In-Reply-To: <20020218134041.A2586@doom.sfo.covalent.net> <3C717C72.72A994D3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C717C72.72A994D3@zip.com.au>; from akpm@zip.com.au on Mon, Feb 18, 2002 at 02:13:06PM -0800
X-Linux: http://zlilo.com/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Mon, Feb 18, 2002 at 02:13:06PM -0800] akpm@zip.com.au wrote:
+ john wrote:
+ > 
+ > hi,
+ > ive searched all over and found many references to this problem, but
+ > never found an actual solution.  the problem is that during heavy
+ > disk I/O, kupdated will periodically take up ALL the cpu.  
+ 
+ I've seen a couple of reports of this, nothing to indicate that it's
+ a common problem?
+ 
+ In the other reports, it was related to extremely low disk throughput.
+ What does `hdparm -t /dev/hda' say?

root@doom:~# hdparm -t /dev/hda

/dev/hda:
 Timing buffered disk reads:  64 MB in 25.60 seconds =  2.50 MB/sec

