Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271738AbRHUQ1b>; Tue, 21 Aug 2001 12:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271740AbRHUQ1V>; Tue, 21 Aug 2001 12:27:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60975 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S271738AbRHUQ1K>; Tue, 21 Aug 2001 12:27:10 -0400
To: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 [I] just run xdos
In-Reply-To: <Pine.LNX.4.33.0108191600580.10914-100000@boston.corp.fedex.com>
	<m166bjokre.fsf@frodo.biederman.org>
	<20010819214322.D1315@squish.home.loc>
	<m1snenmfe0.fsf@frodo.biederman.org>
	<20010820211410.B218@squish.home.loc>
	<m1g0amlzcm.fsf@frodo.biederman.org> <3B828898.BD98D4C4@gmx.at>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Aug 2001 10:20:03 -0600
In-Reply-To: <3B828898.BD98D4C4@gmx.at>
Message-ID: <m1ae0tmll8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wilfried Weissmann <Wilfried.Weissmann@gmx.at> writes:
> 
> I have the same problem on a K7-800. My kernel is 2.4.7-ac3 (with K7
> optimization!). Everything else seems to work fine, but dosemu locks up
> the computer when running certain games.
> Sometimes I can play for quite some time (1/2 hour or more) without
> problems. Eventually it will freeze. It feels like it is triggered by
> mouse activity.

Hmm.  There are some similiar conditions.  And it may be the same bug. 

Is your dosemu not suid root?  And running in X when you are playing those
games?  You don't have any ports lines in your dosemu.conf?

It is very important to rule out dosemu doing direct hardware access, before investigating
something else like the kernel.

Eric
