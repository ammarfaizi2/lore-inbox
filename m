Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTI3QSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbTI3QSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:18:22 -0400
Received: from peabody.ximian.com ([141.154.95.10]:40076 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261631AbTI3QSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:18:21 -0400
Subject: Re: make install problems
From: Kevin Breit <mrproper@ximian.com>
Reply-To: mrproper@ximian.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030930083415.06f155ba.rddunlap@osdl.org>
References: <1064927778.1575.0.camel@localhost.localdomain>
	 <20030930081459.01f447bf.rddunlap@osdl.org>
	 <1064935781.1575.5.camel@localhost.localdomain>
	 <20030930083415.06f155ba.rddunlap@osdl.org>
Content-Type: text/plain
Organization: Ximian, Inc.
Message-Id: <1064938690.1575.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Sep 2003 12:18:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 11:34, Randy.Dunlap wrote:
> On Tue, 30 Sep 2003 11:29:42 -0400 Kevin Breit <mrproper@ximian.com> wrote:
> 
> | On Tue, 2003-09-30 at 11:14, Randy.Dunlap wrote:
> | > On Tue, 30 Sep 2003 09:16:19 -0400 Kevin Breit <mrproper@ximian.com> wrote:
> | > 
> | > | Hey,
> | > | 	I setup a test6 kernel without module support.  I did a make install
> | > | and got:
> | > | 
> | > | Kernel: arch/i386/boot/bzImage is ready
> | > | sh /usr/src/linux-2.6.0-test6/arch/i386/boot/install.sh 2.6.0-test6
> | > | arch/i386/boot/bzImage System.map ""
> | > | /lib/modules/2.6.0-test6 is not a directory.
> | > | mkinitrd failed
> | > | 
> | > | How can I fix this?
> | > 
> | > We've seen this before, and I thought that we had determined that
> | > it was a tools problem.  Is "depmod" in $PATH the depmod from
> | > modutils or the one from module-init-tools?
> | > I.e., what does 'depmod -V' say?
> | 
> | modutils-2.4.22-8
> | 
> | [root@kbreit linux-2.6.0-test6]# depmod -V
> | depmod version 2.4.22
> | 
> | 
> | > and what execs mkinitrd?  I don't find it with a quick grep.
> | 
> | No clue
> 
> You need to use module-init-tools with 2.6.x, not modutils.
> You can find them at
>   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> Just get the latest version.

Why do I need this for a moduleless kernel?

Kevin

