Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTJGOpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 10:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbTJGOpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 10:45:09 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:63717 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262433AbTJGOpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 10:45:04 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16258.53615.17755.970961@laputa.namesys.com>
Date: Tue, 7 Oct 2003 18:45:03 +0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: "E. Gryaznova" <grev@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: Can dbench be used for benchmarking fs?
In-Reply-To: <20031007082944.D1564@schatzie.adilger.int>
References: <3F82B4C6.707221A@namesys.com>
	<20031007082944.D1564@schatzie.adilger.int>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger writes:
 > On Oct 07, 2003  16:42 +0400, E. Gryaznova wrote:
 > > I use dbench for benchmarking the file systems and some results are
 > > suspicious for me.
 > > :
 > > :
 > > :
 > > As the result: the measuring deviation is equal = 23.4062 - 15.7005 =
 > > 7.7057 or about ~38% from average value.
 > > 
 > > So, I have 2 questions :
 > > 1. Is there a way to avoid such big deviations on measuring a file
 > > systems throughput and to get more stable results?
 > > 2. Can dbench be used for benchmarking the file systems and if it is so
 > > -- what is the predictable error on the measuring?
 > 
 > Dbench is not a good filesystem benchmark, because it deletes all of the
 > files at the end.  Use something else for the filesystem benchmark - there

Err... What is wrong with deleting all files at the end? Or do you mean
it should mix file operations during run?

 > are lots of them (bonnie, iozone, mongo, etc).

But why variance is so large?

Another probably interesting observation is that dbench works faster on
ext2 if it is run directly after mkfs.ext2, that is, without reboot
between mkfs and mount.

 > 
 > Cheers, Andreas

Nikita.
