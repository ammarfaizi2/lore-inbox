Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262480AbSJVMhm>; Tue, 22 Oct 2002 08:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262481AbSJVMhm>; Tue, 22 Oct 2002 08:37:42 -0400
Received: from www.wireboard.com ([216.151.155.101]:47048 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id <S262480AbSJVMhm>; Tue, 22 Oct 2002 08:37:42 -0400
To: sean finney <seanius@seanius.net>
Cc: Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: problem opening multiple pipes with pipe(2) in 2.4.1[78]
References: <20021021213220.A26136@sccs.swarthmore.edu>
	<3DB4B517.1070906@redhat.com>
	<20021022003925.A15745@sccs.swarthmore.edu>
From: Doug McNaught <doug@mcnaught.org>
Date: 22 Oct 2002 08:43:23 -0400
In-Reply-To: sean finney's message of "Tue, 22 Oct 2002 00:39:25 -0400"
Message-ID: <m3iszur6dw.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sean finney <seanius@seanius.net> writes:

> right.  the perror() giving nonsensical results wasn't the cause of my
> problem of course, i was just trying to use it to find out why the pipe
> didn't seem to work.  turns out that i missed the forest for the trees;
> the pipe was being opened for writing from the wrong end...
> 
> (as a side note, the code in question was written on a solaris box, and
> it seems to Just Work in the wrong direction there, go fig.)

SysV pipes are bidirectional.

-Doug
