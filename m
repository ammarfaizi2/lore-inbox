Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTAYXBm>; Sat, 25 Jan 2003 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbTAYXBm>; Sat, 25 Jan 2003 18:01:42 -0500
Received: from bitmover.com ([192.132.92.2]:47332 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262780AbTAYXBl>;
	Sat, 25 Jan 2003 18:01:41 -0500
Date: Sat, 25 Jan 2003 15:10:50 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Larry McVoy <lm@bitmover.com>, Jason Papadopoulos <jasonp@boo.net>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: your mail
Message-ID: <20030125231050.GA21095@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Larry McVoy <lm@bitmover.com>, Jason Papadopoulos <jasonp@boo.net>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com> <40475.210.212.228.78.1043384883.webmail@mail.nitc.ac.in> <Pine.LNX.4.44.0301232104440.10187-100000@dlang.diginsite.com> <3.0.6.32.20030124212935.007fcc10@boo.net> <20030125022648.GA13989@work.bitmover.com> <m17kctceag.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17kctceag.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering if there is any point in biasing page addresses in between
> processes so that processes are less likely to have a cache conflict.
> i.e.  process 1 address 0 %16K == 0, process 2 address 0 %16K == 4K 

All good page coloring implementation do exactly that.  The starting
index into the page buckets is based on process id.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
