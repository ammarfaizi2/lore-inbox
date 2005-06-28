Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262076AbVF1Pg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbVF1Pg1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbVF1PgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:36:11 -0400
Received: from w241.dkm.cz ([62.24.88.241]:1952 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262078AbVF1Pfs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:35:48 -0400
Date: Tue, 28 Jun 2005 17:35:45 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Andrew Thompson <andrewkt@aktzero.com>
Cc: Christopher Li <hg@chrisli.org>, mercurial@selenic.com,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Message-ID: <20050628153545.GF1275@pasky.ji.cz>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz> <20050624123819.GD9519@64m.dyndns.org> <20050628150027.GB1275@pasky.ji.cz> <42C16877.6000909@aktzero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C16877.6000909@aktzero.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Jun 28, 2005 at 05:10:47PM CEST, I got a letter
where Andrew Thompson <andrewkt@aktzero.com> told me that...
> Petr Baudis wrote:
> >>Mercurial's undo is taking a snapshot of all the changed file's repo file 
> >>length
> >>at every commit or pull.  It just truncate the file to original size and 
> >>undo is done.
> >
> >"Trunactes"? That sounds very wrong... you mean replace with old
> >version? Anyway, what if the file has same length? It just doesn't make
> >much sense to me.
> 
> I believe this works because the files stored in a binary format that 
> appends new changesets onto the end. Thus, truncating the new stuff from 
> the end effectively removes the commit.

Yes, I'm sorry - I missed the "repo" part and thought that was what it
was doing with the checked out files. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
