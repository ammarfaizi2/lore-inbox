Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272708AbRIPTbo>; Sun, 16 Sep 2001 15:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRIPTbd>; Sun, 16 Sep 2001 15:31:33 -0400
Received: from family.zawodny.com ([63.174.200.26]:16132 "EHLO
	family.zawodny.com") by vger.kernel.org with ESMTP
	id <S272712AbRIPTbY>; Sun, 16 Sep 2001 15:31:24 -0400
Date: Sun, 16 Sep 2001 12:33:09 -0700
From: Jeremy Zawodny <Jeremy@Zawodny.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
Message-ID: <20010916123309.A15108@peach.zawodny.com>
In-Reply-To: <Pine.LNX.4.33L.0109161559500.21279-100000@imladris.rielhome.conectiva> <200109161919.f8GJJwA25036@smtp-server3.tampabay.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109161919.f8GJJwA25036@smtp-server3.tampabay.rr.com>
User-Agent: Mutt/1.3.20i
X-message-flag: Mailbox corrupt.  Please upgrade your mail software.
X-Uptime: 12:32:04 up 49 days, 10:30, 10 users,  load average: 0.01, 0.01, 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 03:19:29PM +0000, Phillip Susi wrote:

> Maybe I'm missing something here, but it seems to me that these
> problems are due to the cache putting pressure on VM, so process
> pages get swapped out.

That's what it felt like in the cases that I ran into it.  It was
trying to treat all memory equally, when it probably shouldn't have.

Jeremy
-- 
Jeremy D. Zawodny     |  Perl, Web, MySQL, Linux Magazine, Yahoo!
<Jeremy@Zawodny.com>  |  http://jeremy.zawodny.com/
