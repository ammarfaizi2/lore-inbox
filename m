Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUD2KTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUD2KTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 06:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUD2KTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 06:19:21 -0400
Received: from gprs214-162.eurotel.cz ([160.218.214.162]:41088 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264045AbUD2KTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 06:19:20 -0400
Date: Thu, 29 Apr 2004 12:19:08 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Timothy Miller <miller@techsource.com>, "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040429101908.GF390@elf.ucw.cz>
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org> <20040427203426.GB6116@openzaurus.ucw.cz> <409036C4.7030102@techsource.com> <20040429094644.GA6098@wohnheim.fh-wedel.de> <20040429095237.GC390@elf.ucw.cz> <20040429100942.GB6098@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040429100942.GB6098@wohnheim.fh-wedel.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 29-04-04 12:09:42, Jörn Engel wrote:
> On Thu, 29 April 2004 11:52:37 +0200, Pavel Machek wrote:
> > 
> > > Ever heard of ssh? ;)
> > 
> > Its too high level, and if you want compression but not encryption
> > that's tricky to do.
> > 
> > > Depending on speed of network and cpus involved, scp can be faster
> > > than nfs.
> > 
> > Well... but that's due to nfs being broken, right?
> 
> I don't think nfs is broken because of missing compression, but yes,
> the difference is by design.

Well, scp is easy, scp is linear copy of file. nfs is little more
tricky. I'm not talking about compression, due to various reasons
(UDP?), nfs is not always able to get the wire speed.
							Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
