Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTB0XrV>; Thu, 27 Feb 2003 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267354AbTB0XrU>; Thu, 27 Feb 2003 18:47:20 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:57756 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S267180AbTB0XrT>;
	Thu, 27 Feb 2003 18:47:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: Rising io_load results Re: 2.5.63-mm1
Date: Fri, 28 Feb 2003 10:56:45 +1100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030227025900.1205425a.akpm@digeo.com> <20030227134403.776bf2e3.akpm@digeo.com> <118810000.1046383273@baldur.austin.ibm.com>
In-Reply-To: <118810000.1046383273@baldur.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302281056.45501.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Feb 2003 09:01 am, Dave McCracken wrote:
> --On Thursday, February 27, 2003 13:44:03 -0800 Andrew Morton
>
> <akpm@digeo.com> wrote:
> >> ...
> >> Mapped:       4294923652 kB
> >
> > Well that's gotta hurt.  This metric is used in making writeback
> > decisions.  Probably the objrmap patch.
>
> Oops.  You're right.  Here's a patch to fix it.

Thanks. 

This looks better after a run:

MemTotal:       256156 kB
MemFree:        189448 kB
Buffers:         46744 kB
Cached:           4176 kB
SwapCached:          0 kB
Active:          51840 kB
Inactive:         1768 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       256156 kB
LowFree:        189448 kB
SwapTotal:     4194272 kB
SwapFree:      4194272 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:        4546752 kB
Slab:             8468 kB
Committed_AS:     7032 kB
PageTables:        200 kB
ReverseMaps:       662

Con
