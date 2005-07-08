Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbVGHBXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbVGHBXm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261363AbVGHBXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 21:23:42 -0400
Received: from quechua.inka.de ([193.197.184.2]:36249 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261297AbVGHBWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 21:22:31 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <2cd57c9005070717446dcc52a1@mail.gmail.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DqhZV-0004yW-00@calista.eckenfels.6bone.ka-ip.net>
Date: Fri, 08 Jul 2005 03:22:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2cd57c9005070717446dcc52a1@mail.gmail.com> you wrote:
> I guess/hope dd always makes it contiguously.

No, it is creating files by appending just like any other file write. One
could think about a call to create unfragmented files however since this is
not always working best is to create those files young or defragment them
before usage.

Gruss
Bernd
