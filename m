Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317940AbSGPRjc>; Tue, 16 Jul 2002 13:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317944AbSGPRjb>; Tue, 16 Jul 2002 13:39:31 -0400
Received: from daimi.au.dk ([130.225.16.1]:35824 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317940AbSGPRj3>;
	Tue, 16 Jul 2002 13:39:29 -0400
Message-ID: <3D345AEE.7CCFDC5B@daimi.au.dk>
Date: Tue, 16 Jul 2002 19:42:06 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: if_exist_pid()
References: <Pine.LNX.3.95.1020716131206.19310A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> Anybody know the 'correct' way of determining if a pid still
> exists?  I've been using "kill(pid, 0)" and, if it does not
> return an error, it is supposed to exist.

That is correct.

> Sending signal 0 to a pid sometimes returns 0, even if the pid
> is long-gone

Really? That would mean there is a bug in kill(). Of course
you can get return value 0 if the pid has been recycled, but
otherwise it should not happen.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
