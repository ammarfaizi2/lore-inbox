Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbUKQQK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbUKQQK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUKQQK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:10:27 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:53476 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262359AbUKQQKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:10:18 -0500
Subject: Re: GPL version, "at your option"?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Cazabon <linux@discworld.dyndns.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041116144029.GA6740@discworld.dyndns.org>
References: <1100614115.16127.16.camel@ghanima>
	 <20041116144029.GA6740@discworld.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100704019.32698.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 15:07:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-16 at 14:40, Charles Cazabon wrote:
>   Also note that the only valid version of the GPL as far as the kernel
>   is concerned is _this_ particular version of the license (ie v2, not
>   v2.2 or v3.x or whatever), unless explicitly otherwise stated.

Version 2 explicitly states

| Each version is given a distinguishing version number.  If the Program
| specifies a version number of this License which applies to it and
"any
| later version", you have the option of following the terms and
conditions
| either of that version or of any later version published by the Free
| Software Foundation.  If the Program does not specify a version number
of
| this License, you may choose any version ever published by the Free
Software
| Foundation.

The use of this by some kernel people is to issue "this version only"
licenses is unfortunate, ill advised and potentially harmful. Firstly it
isn't remotely clear what it means because the license itself never
talks about this case, only the "or later" case. Secondly it may force
code chunks to be rewritten if the GPL is modified to fix a legal
problem in future and the original author or their estate or company [*]
cannot be traced. Thirdly it may actually be meaningless anyway - the
GPL doesn't talk about "this version only" in any of its text so it may
be an "additional restriction" and thus a void clause.

Think very hard before you use such a statement and if you do please
ensure it has some kind of "unlocking" clause so that if you can't be
contacted someone you trust (eg Linus) is authorised to make that
decision for you. It would be good if other people who've used this
would also execute such a change with Linus.

Alan

[*] This isn't that silly a situation the kernel community is large
enough that more than one of its contributors is sadly deceased. The
company case is even worse. Tracing company owned code from a defunct
company is nigh on impossible and if you do trace it to an official
receiver or the equivalent (such as a bankruptcy court) they may be
legally obliged to extort as much money as possible from the person
wanting to relicense it.


