Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270256AbUJTBD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270256AbUJTBD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 21:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270253AbUJTA7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 20:59:39 -0400
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:1411 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S269536AbUJTAek
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 20:34:40 -0400
Date: Wed, 20 Oct 2004 02:34:08 +0200
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Register corruption --patch
Message-ID: <20041020003408.GA6101@finwe.eu.org>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410191112100.4820@chaos.analogic.com>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> This 'C' compiler destroys parameters passed to functions
> even though the code does not alter that parameter.
[example]
> This was from /usr/src/linux-2.6.9/arch/i386/kernel/semaphore.c
> It this case, the value of 'sem' is destroyed which means that
> certain assembly-language helper functions no longer work.
> 
> This was discovered by Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
> 
> I have been having trouble with mysterious things like:
[...]
> (4) Data errors in email.
> (5) Network connections failing to go away `netstat -c` shows
> hundreds of lines of very old history.
> ... etc.
> 

Having troubles with some strange (and -as it seems- temporary) 
data corruptions here[*], I was wondering, whether would it be 
posiible to easily diagnose this somehow?

[*] like diff running serval times over same two files can 
    only once in a while show one character altered 

bye

-- 
Jacek Kawa  **Define the universe.  Give three examples.** [r.h.f.r]
