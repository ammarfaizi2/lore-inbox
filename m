Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268736AbTGVUPW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 16:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268822AbTGVUPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 16:15:22 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:14604 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268736AbTGVUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 16:15:21 -0400
Date: Tue, 22 Jul 2003 21:30:17 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Samuel Flory <sflory@rackable.com>
cc: Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@infradead.org>,
       Roman Zippel <zippel@linux-m68k.org>, michaelm <admin@www0.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Make menuconfig broken
In-Reply-To: <3F1D91F0.2020900@rackable.com>
Message-ID: <Pine.LNX.4.44.0307222129070.17797-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   Well there are 2 issues here:
> 
> 1) How to handle "make oldconfig" on 2.4 config files.  Which may not be 
> fixable in a manner that doesn't involve really ugly code.
> 
> 2) That make menuconfig|xconfig on a clean 2.6 tree results in a kernel 
> that doesn't have console support.   This will be something that will 
> come up over and over again in the future, and does not require ugly 
> hacks to fix.

Instead of hacking up a oldconfig why not have the system detect old 
config files and refuse to build it and tell the user to start from 
scratch. I think this is acceptable.



