Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVCAGxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVCAGxk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 01:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVCAGxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 01:53:40 -0500
Received: from users.linvision.com ([62.58.92.114]:15814 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S261262AbVCAGxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 01:53:38 -0500
Date: Tue, 1 Mar 2005 07:53:36 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] partitions/msdos.c
Message-ID: <20050301065336.GA1567@bitwizard.nl>
References: <20050226213459.GA21137@apps.cwi.nl> <16928.62091.346922.744462@hertz.ikp.physik.tu-darmstadt.de> <Pine.LNX.4.58.0502261424430.25732@ppc970.osdl.org> <20050226225203.GA25217@apps.cwi.nl> <Pine.LNX.4.58.0502261510030.25732@ppc970.osdl.org> <20050226234053.GA14236@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226234053.GA14236@apps.cwi.nl>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 12:40:53AM +0100, Andries Brouwer wrote:
> (Concerning the "size" version: it occurred to me that there is one
> very minor objection: For extended partitions so far the size did
> not normally play a role. Only the starting sector was significant.
> If, at some moment we decide also to check the size, then a weaker
> check, namely only checking for non-extended partitions, might be
> better at first.)

I recently encountered a disk that had clipping enabled. If you go
for the size implementation be careful that people can still run a 
program to unclip the disk after the disk has been detected and the
partition rejected.... 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
Q: It doesn't work. A: Look buddy, doesn't work is an ambiguous statement. 
Does it sit on the couch all day? Is it unemployed? Please be specific! 
Define 'it' and what it isn't doing. --------- Adapted from lxrbot FAQ
