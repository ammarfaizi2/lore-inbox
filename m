Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbSLUXMg>; Sat, 21 Dec 2002 18:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSLUXMg>; Sat, 21 Dec 2002 18:12:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:4559 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265094AbSLUXMf>;
	Sat, 21 Dec 2002 18:12:35 -0500
Message-ID: <3E04F742.DD396736@digeo.com>
Date: Sat, 21 Dec 2002 15:20:34 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.52, load and process in D state
References: <20021221203246.16082.qmail@linuxmail.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Dec 2002 23:20:35.0185 (UTC) FILETIME=[907F9E10:01C2A947]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> 
> Hi all,
> I booted 2.5.52 with the following parmater:
> apm=off mem=32M (not sure about the amount, anyway I can reproduce
> the problem for sure with 32M and 40M)
> 
> Then I tried the osdb (www.osdb.org) benchmark with
> 40M of data.
> 
> $./bin/osdb-pg --nomulti
> 
> the result is that aftwer a few second running top I see the postmaster
> process in D state and a lot if iowait.

What exactly _is_ the issue?  The machine is achieving 25% CPU utilisation
in user code, 6-9% in system code.  It is doing a lot of I/O, and is
getting work done.
