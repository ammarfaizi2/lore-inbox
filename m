Return-Path: <linux-kernel-owner+w=401wt.eu-S1752433AbWLQLHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbWLQLHR (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 06:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752435AbWLQLHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 06:07:16 -0500
Received: from smtp2.tech.numericable.fr ([82.216.111.38]:36271 "EHLO
	smtp2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbWLQLHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 06:07:15 -0500
Date: Sun, 17 Dec 2006 12:07:10 +0100
From: Damien Wyart <damien.wyart@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.20-rc1-mm1
Message-ID: <20061217110710.GA1994@localhost.localdomain>
References: <20061214225913.3338f677.akpm@osdl.org> <20061215203936.GA2202@localhost.localdomain> <20061215130141.fd6a0c25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215130141.fd6a0c25.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Also, I got panics when unmounting reiser4 filesystems with
> > 2.6.20-rc1-mm1 but I guess this is related to your waring about
> > reiser4 being broken in 2.6.19-mm1 (even if it is not listed in
> > notes for 2.6.20-rc1-mm1)... I attach dmesg and config, but the
> > reiser4 panics did not get logged and I am not able to reboot on
> > 2.6.20-rc1-mm1 right now. For the moment, I mainly wanted to report
> > the xfs messages which seems a bit suspect.

> The reiser4 failure is unexpected. Could you please see if you can
> capture a trace, let the people at reiserfs-dev@namesys.com know?

Ok, I've handwritten the messages, here they are :

reiser4 panicked cowardly : reiser4[umount(2451)] : commit_current_atom (fs/reiser4/txmngr.c:1087) (zam-597)
write log failed (-5)

[ got 2 copies of them because I have 2 reiser4 fs)

I got them mainly when I try to reboot or halt the machine, and the
process doesn't finish, the computer gets stuck after the reiser4
messages. This is only with 2.6.20-mm1, not 2.6.19-rc6-mm2.

-- 
Damien Wyart
