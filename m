Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTJTVBt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbTJTVBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 17:01:32 -0400
Received: from dslb138.fsr.net ([12.7.7.138]:46237 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S262782AbTJTVAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 17:00:42 -0400
Message-ID: <1066683638.3f944cf6e6763@horde.sandall.us>
Date: Mon, 20 Oct 2003 14:00:38 -0700
From: Eric Sandall <eric@sandall.us>
To: Nir Tzachar <tzachar@cs.bgu.ac.il>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: srfs - a new file system.
References: <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
In-Reply-To: <Pine.LNX.4.44_heb2.09.0310201031150.20172-100000@nexus.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 134.121.40.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nir Tzachar <tzachar@cs.bgu.ac.il>:
> hello all.
> 
> We're proud to announce the availability of a _proof of concept_ file
> system, called srfs. ( http://www.cs.bgu.ac.il/~srfs/ ).
> a quick overview: [from the home page]
> srfs is a global file system designed to be distributed geographicly over
> multiple locations and provide a consistent, high available and durable
> infrastructure for information.
> 
> Started as a research project into file systems and self-stabilization in
> Ben Gurion University of the Negev Department of Computer Science, the
> project aims to integrate self-stabilization methods and algorithms into
> the file (and operation) systems to provide a system with a desired
> behavior in the presence of transient faults.
> 
> Based on layered self-stabilizing algorithms, provide a tree replication
> structure based on auto-discovery of servers using local and global IP
> multicasting. The tree structure is providing the command and timing
> infrastructure required for a distributed file system.
> 
> The project is basically divided into two components:
> 1) a kernel module, which provides the low level functionality, and
>    disk management.
> 2) a user space caching daemon, which provide the stabilization and
>    replication properties of the file system.
> these two components communicate via a character device.
> 
> more info on the system architecture can be find on the web page, and
> here: http://www.cs.bgu.ac.il/~tzachar/srfs.pdf
> 
> We hope some will find this interesting enough to take for a test drive,
> and wont mind the latencies ( currently, the caching daemon is a bit slow.
> hopefully, we will improve it in the future. )
> anyway, please keep in mind this is a very early version that only works,
> and keeps the stabilization properties. no posix compliance whatsoever...
> 
> the code contains several hacks and design flaws that we're aware of,
> and probably many that we're not... so please be gentle ;)
> 
> if someone found this interesting, please contact us with ur insights.
> cheers,
> the srfs team.
> 
> p.s I would like to thank all members of this mailing list (fsdevel), for
> ur continual help with problems we encountered during the development.
> thanks guys (and girls???).
> 
> ========================================================================
> nir.

This sounds fairly similar to Coda[0], which is already in development and use.

-sandalle

[0] http://www.coda.cs.cmu.edu/

-- 
PGP Key Fingerprint:  FCFF 26A1 BE21 08F4 BB91  FAED 1D7B 7D74 A8EF DD61
http://search.keyserver.net:11371/pks/lookup?op=get&search=0xA8EFDD61

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCS/E/IT$ d-- s++:+>: a-- C++(+++) BL++++VIS>$ P+(++) L+++ E-(---) W++ N+@ o?
K? w++++>-- O M-@ V-- PS+(+++) PE(-) Y++(+) PGP++(+) t+() 5++ X(+) R+(++)
tv(--)b++(+++) DI+@ D++(+++) G>+++ e>+++ h---(++) r++ y+
------END GEEK CODE BLOCK------

Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
