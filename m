Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315544AbSGQRjf>; Wed, 17 Jul 2002 13:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315941AbSGQRje>; Wed, 17 Jul 2002 13:39:34 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41127 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S315544AbSGQRje>;
	Wed, 17 Jul 2002 13:39:34 -0400
Date: Thu, 18 Jul 2002 19:40:19 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: shreenivasa H V <shreenihv@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Gang Scheduling in linux
In-Reply-To: <Pine.LNX.4.44.0207181818300.29003-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207181930170.32666-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


you are right in that the Linux scheduler does not enable classic
gang-scheduling: where multiple processes are scheduled 'at once' on
multiple CPUs. Can you point out specific (real-life) workloads where this
would be advantegous? Some testcode would be the best form of expressing
this. Pretty much any job that uses sane (kernel-based or kernel-helped)
synchronization should see good throughput.

	Ingo

