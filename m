Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUDUAVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUDUAVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbUDUAVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 20:21:10 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:35773 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263807AbUDUAVH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 20:21:07 -0400
Date: Tue, 20 Apr 2004 17:21:02 -0700
From: Andy Isaacson <adi@bitmover.com>
To: "Giacomo A. Catenazzi" <cate@debian.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Compile error in main.c [2.6.bk]
Message-ID: <20040421002102.GB27313@bitmover.com>
References: <407F821A.3040908@debian.org> <20040418040111.GR3445@bakeyournoodle.com> <40836E12.8000402@debian.org> <20040419092155.1614862a.rddunlap@osdl.org> <40840565.6000304@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40840565.6000304@debian.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:59:17PM +0200, Giacomo A. Catenazzi wrote:
> Randy.Dunlap wrote:
> >2.6.6-rc1-bk4 builds for me with your .config file.
> >Were you using something earlier than (before) rc1-bk4 ?
> 
> I'm using the latest linus bk version
> 
> VERSION = 2
> PATCHLEVEL = 6
> SUBLEVEL = 6
> EXTRAVERSION =-rc1
> NAME=Zonked Quokka
> 
> 
> hmm:
> 
> cate@catee:~/kernel/5,v2.5/bk/linus-2.5$ find include/ | grep audit
> include/linux/SCCS/s.audit.h
> include/config/audit.h
> 
> but no include/linux/audit.h as used in include/linux/fs.h
> 
> Corrupted local bk?

I realize I'm behind on list mail, and this might be irrelevant
already...

Does "bk -r check -acv" report any problems on that repo?

-andy
