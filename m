Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273189AbRIPIyo>; Sun, 16 Sep 2001 04:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273190AbRIPIye>; Sun, 16 Sep 2001 04:54:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:61255 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S273189AbRIPIyO>; Sun, 16 Sep 2001 04:54:14 -0400
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <Pine.LNX.4.33L2.0109160031500.7740-100000@flashdance>
	<9o1dev$23l$1@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Sep 2001 02:45:51 -0600
In-Reply-To: <9o1dev$23l$1@penguin.transmeta.com>
Message-ID: <m1n13vsev4.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:

> Don't look at how many pages of swap were used. That's a statistic,
> nothing more.

It is a statistic until you run out of them.  Obviously that isn't
the problem here, or we'd hear complaints about the OOM killer.  But
the number of pages used can make a difference.

Eric
