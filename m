Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268869AbRG0Pj2>; Fri, 27 Jul 2001 11:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268874AbRG0PjS>; Fri, 27 Jul 2001 11:39:18 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:23559 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S268869AbRG0PjJ>; Fri, 27 Jul 2001 11:39:09 -0400
Message-ID: <3B618AE4.983439DC@namesys.com>
Date: Fri, 27 Jul 2001 19:38:12 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33.0107271653210.12396-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This "feature" of not guaranteeing that a write that is in progress when the machine crashes will
not write garbage, has been present in most Unix filesystems for about 25 years of Unix history.  It
is not that we are deviant on this, it is that a tradeoff is made, and for most but not all users it
is a good one to make.

reiser4 will do it better though by making data logging available as an option with only a moderate
performance penalty.

Hans
