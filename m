Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUFAMjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUFAMjZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 08:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUFAMjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 08:39:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2969 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265009AbUFAMjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 08:39:24 -0400
Date: Tue, 1 Jun 2004 13:39:22 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040601123921.GN12308@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0405251607520.26157-100000@chimarrao.boston.redhat.com> <20040525211522.GF29378@dualathlon.random> <20040526103303.GA7008@elte.hu> <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040601055616.GD15492@wohnheim.fh-wedel.de> <20040601060205.GE15492@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040601060205.GE15492@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 08:02:05AM +0200, Jörn Engel wrote:
> Add recursion markers to teach automated test tools how bad documented
> recursions really are.  Currently, there is only a single such too that
> can use the information and there is always the danger of documentation
> and reality getting out of sync.  But until there's a better tool...
 
> +/**
> + * RECURSION:	100
> + * STEP:	register_proc_table
> + */

This is too ugly for words ;-/  Who will maintain that data, anyway?
