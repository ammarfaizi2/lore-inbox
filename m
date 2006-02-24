Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWBXOo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWBXOo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWBXOo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:44:28 -0500
Received: from thunk.org ([69.25.196.29]:44767 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932187AbWBXOo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:44:27 -0500
Date: Fri, 24 Feb 2006 09:44:16 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: Dave Jones <davej@redhat.com>, Rene Herman <rene.herman@keyaccess.nl>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
Message-ID: <20060224144416.GA11669@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>,
	Dave Jones <davej@redhat.com>,
	Rene Herman <rene.herman@keyaccess.nl>,
	Linus Torvalds <torvalds@osdl.org>,
	Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> <1140707358.4672.67.camel@laptopd505.fenrus.org> <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org> <43FE1764.6000300@keyaccess.nl> <20060223202638.GD6213@redhat.com> <1140749055.2411.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140749055.2411.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 11:44:15AM +0900, Fernando Luis Vazquez Cao wrote:
> 
> The mkdump team has been using runtime relocatable kernels for two years
> and we are currently working on porting this functionality to kdump. I
> was wondering if it would be accepted mainstream.

What's the overhead?  (In code size, complexity, performance, etc.?)

						- Ted
