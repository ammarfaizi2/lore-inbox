Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWJTPrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWJTPrU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 11:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWJTPrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 11:47:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6577 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932219AbWJTPrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 11:47:18 -0400
Date: Fri, 20 Oct 2006 11:46:28 -0400
From: Bill Nottingham <notting@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Albert Cahalan <acahalan@gmail.com>,
       Cal Peake <cp@absolutedigital.net>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT] Grep to find users of sys_sysctl.
Message-ID: <20061020154628.GA2734@nostromo.devel.redhat.com>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Albert Cahalan <acahalan@gmail.com>,
	Cal Peake <cp@absolutedigital.net>, Andi Kleen <ak@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <787b0d920610181123q1848693ajccf7a91567e54227@mail.gmail.com> <Pine.LNX.4.64.0610181129090.3962@g5.osdl.org> <Pine.LNX.4.64.0610181443170.7303@lancer.cnet.absolutedigital.net> <20061018124415.e45ece22.akpm@osdl.org> <m17iyw7w92.fsf_-_@ebiederm.dsl.xmission.com> <Pine.LNX.4.64.0610191218020.32647@lancer.cnet.absolutedigital.net> <m1wt6v4gcx.fsf_-_@ebiederm.dsl.xmission.com> <20061020075234.GA18645@flint.arm.linux.org.uk> <m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wt6v2gts.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman (ebiederm@xmission.com) said: 
> - module_upgrade seems to be setting the printk verbosity?

Reading the current verbosity; setting it is done with sys_syslog.
Could be ported to read it out of /proc/sys/kernel/printk; that's
just more lines of code. (All this code is dying anyway, so... eh,
whatever.)

Bill
