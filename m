Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285704AbSAGTbj>; Mon, 7 Jan 2002 14:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285703AbSAGTb3>; Mon, 7 Jan 2002 14:31:29 -0500
Received: from coffee.psychology.McMaster.CA ([130.113.218.59]:36508 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S285691AbSAGTb0>; Mon, 7 Jan 2002 14:31:26 -0500
Date: Mon, 7 Jan 2002 14:31:53 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFT] simple deadline I/O scheduler
In-Reply-To: <20020105133800.A37@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0201071429470.5017-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would it be possible to introduce concept of I/O priority? I.e. I want 
> updatedb not to load disk if I need it for something else?

makes sense to me.  actually, VM is another place where priority
could be quite useful - for instance, how hard the VM scavenges 
a proc's pages.  oops, there I go advocating a tunable...

VM_SWAP_ME_HARDER anyone?

