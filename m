Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264059AbTDOUAB (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 16:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264060AbTDOUAB 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 16:00:01 -0400
Received: from air-2.osdl.org ([65.172.181.6]:58073 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264059AbTDOUAA 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 16:00:00 -0400
Date: Tue, 15 Apr 2003 13:10:43 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: eli.carter@inet.com, linux-kernel@vger.kernel.org
Subject: Re: [OT] patch splitting util(s)?
Message-Id: <20030415131043.1cdcbe44.rddunlap@osdl.org>
In-Reply-To: <200304150047.h3F0lXc22483@devserv.devel.redhat.com>
References: <3E9B2C38.4020405@inet.com>
	<20030414215128.GA24096@suse.de>
	<mailman.1050360781.7083.linux-kernel2news@redhat.com>
	<200304150047.h3F0lXc22483@devserv.devel.redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003 20:47:33 -0400 Pete Zaitcev <zaitcev@redhat.com> wrote:

| >>  > I didn't have much luck with googling.  I think the words I used are too 
| >>  > generic.  :/
| >>  
| >> Google for diffsplit. Its part of Tim Waugh's patchutils.
| >> Patchutils should be part of pretty much every distro these days too.
| > 
| > I'm aware of patchutils.  (Check the 0.2.22 Changelog ;) )  However, 
| > splitdiff doesn't do what I'm after, from my initial look.  Though now 
| > that I think about it, it suggests an alternative solution.  A 
| > 'shatterdiff' that created one diff file per hunk in a patch would give 
| > me basically what I want.
| 
| I moaned at Tim until he caved in and added an '-s' option
| couple of weeks ago. It should be in a fresh rawhide srpm.
| 
| Mind, you can do what you want even now, with -n (for line numbers)
| and a little bit of sh or perl, but all concievable solutions
| require several passes over the diff, which gets tiresome
| if you diff 2.4.9 (RH 7.2) and 2.4.18 (RH 8.0). The -s option
| does it in one pass.

so when does this change show up at http://cyberelk.net/tim/patchutils/ ?

--
~Randy
