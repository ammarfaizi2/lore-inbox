Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUL3GNn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUL3GNn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 01:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbUL3GNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 01:13:43 -0500
Received: from quechua.inka.de ([193.197.184.2]:19871 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261548AbUL3GNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 01:13:41 -0500
From: Bernd Eckenfels <ecki-news2004-12@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Is CAP_SYS_ADMIN checked by every program !?
Organization: Deban GNU/Linux Homesite
In-Reply-To: <200412300546.iBU5kVie023979@turing-police.cc.vt.edu>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CjtZ4-0001p9-00@calista.eckenfels.6bone.ka-ip.net>
Date: Thu, 30 Dec 2004 07:13:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200412300546.iBU5kVie023979@turing-police.cc.vt.edu> you wrote:
> If you actually log your kernel messages it can matter, if every single
> process suddenly starts dumping a line in your syslogs, especially on a
> busy system...

It does not, the patch is not part of the linux kernel. There is nothing
which is tracing permission checks. 

Of course this might become interesting, if you want to do full audit log,
however the current functionality in the kernel infrastructure is not very
well suited for that, since you would habe to do stack analysis for
meaningful traces (like "who checked access permission, why")


Gruss
Bernd
