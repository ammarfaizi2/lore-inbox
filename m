Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261717AbTCKXY5>; Tue, 11 Mar 2003 18:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261722AbTCKXY5>; Tue, 11 Mar 2003 18:24:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60687 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261717AbTCKXY4>; Tue, 11 Mar 2003 18:24:56 -0500
Date: Tue, 11 Mar 2003 15:18:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: george@mvista.com, <felipe_alfaro@linuxmail.org>, <cobra@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Runaway cron task on 2.5.63/4 bk?
In-Reply-To: <20030311150913.20ddb760.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303111517020.1709-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Mar 2003, Andrew Morton wrote:
>
> 2.95.3 and 3.2.1 seem to do it right?

Try the "64x32->64" version. gcc didn't use to get that one right, but
maybe it does now.

		Linus

