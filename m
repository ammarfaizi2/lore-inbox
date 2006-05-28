Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWE1KAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWE1KAI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 06:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWE1KAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 06:00:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:22703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750701AbWE1KAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 06:00:07 -0400
X-Authenticated: #1490710
Date: Sun, 28 May 2006 12:00:01 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Martin Langhoff <martin.langhoff@gmail.com>, Jeff Garzik <jeff@garzik.org>,
       Git Mailing List <git@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SCRIPT] chomp: trim trailing whitespace
In-Reply-To: <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0605281157330.1862@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4477B905.9090806@garzik.org> <46a038f90605270828u7842ea48hda07331388694db2@mail.gmail.com>
 <Pine.LNX.4.64.0605270905190.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 27 May 2006, Linus Torvalds wrote:

> Well, git-stripspace actually does something slightly differently, in that 
> it also removes extraneous all-whitespace lines from the beginning, the 
> end, and the middle (in the middle, the rule is: two or more empty lines 
> are collapsed into one).
> 
> Ie it's a total hack for parsing just commit messages (and it is in C, 
> because I can personally write 25 lines of C in about a millionth of the 
> time I can write 3 lines of perl).

But there is no good reason not to add some code and a command line 
switch, so that this tool with a very generic name actually performs what 
a normal person would expect from that name.

Ciao,
Dscho

