Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267370AbUIJQLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267370AbUIJQLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267464AbUIJQIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:08:41 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:55491 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S267538AbUIJQEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:04:05 -0400
Date: Fri, 10 Sep 2004 17:04:35 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Latest microcode data from Intel.
In-Reply-To: <1094828066.17442.4.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409101702270.1294-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Alan Cox wrote:
> > The microcode_ctl utility had a hardcoded default "/dev/cpu/microcode" and 
> > there is no real reason to change it because different distributions 
> > prefer a different value, so how to decide who is "right"?
> 
> Documentation/devices.txt aka LANANA

Ok, in that case microcode_ctl is right about "/dev/cpu/microcode" and 
distributions need to change to match it. Indeed, it always seemed silly 
to me to "pretend" that the microcode device node is "per cpu" in some 
sense (as it is impossible under Linux to bind userspace app to a given 
cpu then there is no "good" sense in which "per cpu" node can be defined).

Kind regards
Tigran

