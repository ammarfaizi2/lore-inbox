Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289793AbSA2SKT>; Tue, 29 Jan 2002 13:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289795AbSA2SKJ>; Tue, 29 Jan 2002 13:10:09 -0500
Received: from ns.suse.de ([213.95.15.193]:26643 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289793AbSA2SJ7>;
	Tue, 29 Jan 2002 13:09:59 -0500
Date: Tue, 29 Jan 2002 19:09:57 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Craig DeForest <zowie@euterpe.boulder.swri.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: MTRR hangs dual-athlon SMP system (2.4.16 - 2.4.18p7)
In-Reply-To: <15446.57543.295705.495830@euterpe.boulder.swri.edu>
Message-ID: <Pine.LNX.4.33.0201291909020.13856-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Craig DeForest wrote:

> Principal workaround is to switch off MTRR support.  That works for
> me, but gives a noticeable (maybe 10%) performance hit in my application.
> More memory-intensive applications will be hit harder.

Can you include the output of /proc/mtrr, and any mtrr related
messages in dmesg ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

