Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbVAWQHC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbVAWQHC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 11:07:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbVAWQHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 11:07:02 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:17272 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261321AbVAWQG6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 11:06:58 -0500
Subject: DVD burning still have problems
From: Kasper Sandberg <lkml@metanurb.dk>
To: LKML Mailinglist <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 17:06:54 +0100
Message-Id: <1106496414.14219.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello, i followed the last thread, "unable to burn DVD", and there was a
patch, which was said to work, but it does not.. (i am running
2.6.11-rc1-bk9)..

the problem started around 2.6.9 (or something like it), when i was only
able to burn 1 dvd, then i had to restart before i could burn another
(or every second dvd i burn would fail), the error i get is input/output
error.. my burner is working perfect, since it works on windows, and on
2.6.9-rcSomething.

it is not a specific place in the burning process it fails, sometimes at
10%, and sometimes at 97%

burning normal cd's works perfectly

now on 2.6.10 and 2.6.11-later i cant burn dvd's at all, every time i
try to burn one, it fails, i have tried different speeds and media, same
thing, i got a Liteon sohw1213S dvd duallayer burner, allthough im not
using duallayer media.

here is a log from a burning i just tried:
/dev/hda: engaging DVD-R DAO upon user request...
/dev/hda: reserving 2149200 blocks
/dev/hda: "Current Write Speed" is 4.1x1385KBps.
  0.02% done, estimate finish Tue Jan 25 13:20:53 2005
  0.05% done, estimate finish Mon Jan 24 15:13:15 2005
<snip>
 83.66% done, estimate finish Sun Jan 23 16:50:47 2005
 83.68% done, estimate finish Sun Jan 23 16:50:47 2005
 83.71% done, estimate finish Sun Jan 23 16:50:46 2005
:-[ WRITE@LBA=1b7460h failed with SK=3h/ASC=0Ch/ACQ=00h]: Input/output
error
:-( write failed: Input/output error
/dev/hda: flushing cache

this is simply what happens :(
i have tried with and without pktcdvd loaded, same result, i hope
someone can help me

thanks

