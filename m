Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932431AbWAQVl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbWAQVl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAQVl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:41:58 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:35341 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932438AbWAQVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:41:57 -0500
Date: Tue, 17 Jan 2006 22:41:49 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Ram Gupta <ram.gupta5@gmail.com>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
Message-ID: <20060117214149.GA30467@w.ods.org>
References: <43CA883B.2020504@superbug.demon.co.uk> <20060115192711.GO7142@w.ods.org> <43CCE5C8.7030605@superbug.demon.co.uk> <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr> <43CD599B.8050002@superbug.demon.co.uk> <728201270601171332v6c95df17u167d15212dde66c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728201270601171332v6c95df17u167d15212dde66c4@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 03:32:11PM -0600, Ram Gupta wrote:
> On 1/17/06, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
> > Jan Engelhardt wrote:
> > >>My point is that there is no way to tell what kills me. No messages in
> > >>syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
> > >>least dmesg?
> 
> You may try using strace . It may throw some light on the cause of the problem.

I would particularly suggest using 'strace -tt' both on X and on the
python process. It will make it easier to analyse the causes later. You
might even encounter a bug in the python application causing an explicit
kill of a miscalculated pid (although unlikely, but who knows ?).

> Regards
> Ram gupta

Regards,
Willy

