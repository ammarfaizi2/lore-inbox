Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265665AbUBBPgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUBBPgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 10:36:42 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:7872 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265665AbUBBPgl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 10:36:41 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16414.28295.459818.511662@laputa.namesys.com>
Date: Mon, 2 Feb 2004 18:36:39 +0300
To: Pavel Machek <pavel@ucw.cz>
Cc: Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace filesystems (WAS: Encrypted Filesystem)
In-Reply-To: <20040202151953.GA262@elf.ucw.cz>
References: <OFA97B290B.67DE842E-ON87256E27.0061728C-86256E27.0061BB0E@us.ibm.com>
	<y2ar7xmkyqe.fsf@cartman.at.fivegeeks.net>
	<200401281350.i0SDo2I03247@duna48.eth.ericsson.se>
	<20040130170610.GB625@elf.ucw.cz>
	<200402020942.i129gHf15172@duna48.eth.ericsson.se>
	<20040202151953.GA262@elf.ucw.cz>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 

[...]

 > 
 > Transient real failure looks pretty ugly. I'd not expect
 > read(/etc/passwd) to return -ENOMEM, and read(/#ftp:somewhere/passwd)

read(/etc/passwd) can fail with -ENOMEM while allocating a page in the
page cache.

 > should be the same, but as this is basically "can not happen"... I
 > guess that's enough.
 > 								Pavel

Nikita.

