Return-Path: <linux-kernel-owner+w=401wt.eu-S1755077AbWL2WtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077AbWL2WtH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbWL2WtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:49:07 -0500
Received: from aa017msg.fastweb.it ([213.140.2.84]:39923 "EHLO
	aa017msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbWL2WtG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:49:06 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Dec 2006 17:49:05 EST
Date: Fri, 29 Dec 2006 23:43:09 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20061229224309.GA23445@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200612291859.kBTIx2kq031961@hera.kernel.org>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 06:59:02PM +0000, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7658cc289288b8ae7dd2c2224549a048431222b3
> Commit:     7658cc289288b8ae7dd2c2224549a048431222b3
> Parent:     3bf8ba38f38d3647368e4edcf7d019f9f8d9184a
> Author:     Linus Torvalds <torvalds@macmini.osdl.org>
> AuthorDate: Fri Dec 29 10:00:58 2006 -0800
> Committer:  Linus Torvalds <torvalds@macmini.osdl.org>
> CommitDate: Fri Dec 29 10:00:58 2006 -0800
> 
>     VM: Fix nasty and subtle race in shared mmap'ed page writeback

With 2.6.20-rc2-git1, which contain this patch, I have no more Berkeley
DB corruption with Klibido.¹
I'm afraid a lot of software project switched to Sqlite,² from BDB,³
because the bug this patch fix (ie. http://bogofilter.sourceforge.net/).
I've also thought, since years, it was an userland problem.

Ciao,
gelma

-------------------
¹ http://klibido.sourceforge.net/
² http://www.sqlite.org/
³ http://www.oracle.com/database/berkeley-db/index.html
