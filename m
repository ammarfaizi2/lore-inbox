Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUJWHWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUJWHWN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 03:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJWHWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 03:22:13 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:51600 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263736AbUJWHWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 03:22:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VCH4emZvflr+wgcGuiiFCzYKGsmS/JRwA48nQzqOgs6gTqqTEp31aARwmU0DJXe2RkcyswwJY4vXj2tSVXiWYzQwJOeQbE8iWSZyRwg/pHGvZjodD/xMqxRZXVZpynQSu+aJE6UUXnDLYU+sdW97rCuIhhJQcMRfMLyKOnqWvcY=
Message-ID: <3aa654a404102300221317f104@mail.gmail.com>
Date: Sat, 23 Oct 2004 00:22:11 -0700
From: Avuton Olrich <avuton@gmail.com>
Reply-To: Avuton Olrich <avuton@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041022032039.730eb226.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 03:20:39 -0700, Andrew Morton <akpm@osdl.org> wrote:

>   - reiser4: not sure, really.  The namespace extensions were disabled,
>     although all the code for that is still present.  Linus's filesystem
>     criterion used to be "once lots of people are using it, preferably when
>     vendors are shipping it".  That's a bit of a chicken and egg thing though.
>     Needs more discussion.

*Disclamer: My first post to the list, sorry if something's wrong with
it (blame gmail ;P)*

I've been using reiser4 in four of my computers since it was in -mm.
All partitions (excl. /boot), including 2 boxes that have been up
since (well, reboots for -mm updates from time to time) the reiser4
conversion and not a hiccup since. I'm always shocked when people
speak about how my computers are going to blow up, how people who run
reiser4 must be insane, etc... I've heard it all. Truth is, at the end
of the day, me, Joe End User, has had no issues. I'm not here to say
it's perfect (only the programmers know for sure, IANAP), but it's far
from unpredictable.

The fs's have taken their share of beatings too, testing the new ACPI
stuff lately has lead to plenty of lockups and reiser4 deals much
better than filesystems I have played with in the past.

What I'm trying to say here is I've seen more instability in other
places in the kernel lately than I've seen come from reiser4 at all.
What hurts when including it, when people have the choice not to
compile in and have the big EXPERIMENTAL warning?
