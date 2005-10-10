Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbVJJLCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVJJLCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 07:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVJJLCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 07:02:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:24806 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750744AbVJJLCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 07:02:51 -0400
To: jmerkey <jmerkey@utah-nac.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix ext3 warning for unused var
References: <20051009195850.27237.90873.stgit@zion.home.lan>
	<Pine.LNX.4.64.0510091314200.31407@g5.osdl.org>
	<43497533.6090106@utah-nac.org>
	<20051009212916.GM7992@ftp.linux.org.uk>
	<43497B09.3020102@utah-nac.org>
	<20051009220838.GN7992@ftp.linux.org.uk>
	<200510092358.j99NwlQj021703@turing-police.cc.vt.edu>
	<43499E10.8060502@utah-nac.org>
From: Andi Kleen <ak@suse.de>
Date: 10 Oct 2005 13:02:47 +0200
In-Reply-To: <43499E10.8060502@utah-nac.org>
Message-ID: <p73psqdy6qw.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey <jmerkey@utah-nac.org> writes:
> 
> Yep.   Needs to get fixed because when you upgrade from a reiserfs
> system and try to keep the reiserfs partitions and add a new hard
> drive (+1) to
> an existing system, you run the risk of corrupting resiferfs
> partitions. Jeff

Newer mkreiserfs overwrites the beginning of the partition to 
avoid that. Probably yours was created with a very old one.

-Andi
