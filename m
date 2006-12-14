Return-Path: <linux-kernel-owner+w=401wt.eu-S1751855AbWLNA2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWLNA2g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbWLNA2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:28:35 -0500
Received: from mail.lmcg.wisc.edu ([144.92.101.145]:50815 "EHLO
	mail.lmcg.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbWLNA2f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:28:35 -0500
X-Greylist: delayed 1231 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:28:35 EST
Date: Wed, 13 Dec 2006 18:08:01 -0600
From: Daniel Forrest <forrest@lmcg.wisc.edu>
To: linux-kernel@vger.kernel.org
Subject: Processes with hidden PID files in /proc
Message-ID: <20061213180801.A16952@yoda.lmcg.wisc.edu>
Reply-To: Daniel Forrest <forrest@lmcg.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully someone can give me a quick answer...

Yesterday I discovered some processes that had a PPID which was not
shown as a running process by "ps".  Also an "ls /proc" did not show
that PPID.

I've Googled on this enough to find out that these are Linux threads,
that "ps -m" will show them, that "ls -a /proc" will show /proc/.PPID,
etc, but I'm still wondering what exact sequence of system calls will
create a process like this?

I'm trying to file a bug report for another piece of software and I
would like to make a simple test program that shows this situation.

Thanks,

-- 
Daniel K. Forrest	Laboratory for Molecular and
forrest@lmcg.wisc.edu	Computational Genomics
(608) 262 - 9479	University of Wisconsin, Madison
