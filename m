Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130053AbRCAWdm>; Thu, 1 Mar 2001 17:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130063AbRCAWdc>; Thu, 1 Mar 2001 17:33:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26128 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130053AbRCAWdY>; Thu, 1 Mar 2001 17:33:24 -0500
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
To: riel@conectiva.com.br (Rik van Riel)
Date: Thu, 1 Mar 2001 22:36:29 +0000 (GMT)
Cc: mikeg@wen-online.de (Mike Galbraith),
        marcelo@conectiva.com.br (Marcelo Tosatti),
        linux-kernel@vger.kernel.org (linux-kernel),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.33.0103011747560.1961-100000@duckman.distro.conectiva> from "Rik van Riel" at Mar 01, 2001 06:05:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14YbgW-0000Hk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Except that your code throws the random junk at the elevator all
> the time, while my code only bothers the elevator every once in
> a while. This should make it possible for the disk reads to
> continue with less interruptions.

Think about it this way, throwing the stuff at the I/O layer is saying
'please make this go away'. Thats the VM decision. Scheduling the I/O is an
I/O and driver layer decision. 




