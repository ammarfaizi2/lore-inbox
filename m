Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbUBXSJG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:09:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbUBXSJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:09:06 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:44225 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262365AbUBXSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:08:54 -0500
Date: Tue, 24 Feb 2004 18:07:29 +0000
From: Dave Jones <davej@redhat.com>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, davem@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040224180729.GM11203@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	davem@redhat.com, Linus Torvalds <torvalds@osdl.org>
References: <1077590524.8084.237.camel@cube> <20040224164404.GB10157@redhat.com> <1077635481.8120.300.camel@cube> <20040224173444.GL11203@redhat.com> <1077636547.8084.303.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077636547.8084.303.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 10:29:07AM -0500, Albert Cahalan wrote:

 > >  > I'm just saying it would be neat, and potentially
 > >  > useful, to intentionally violate this. Of greatest
 > >  > interest would be the 2-way Opteron boards that
 > >  > only have RAM connected to the CPU closest to PCI.
 > >  > The sidecar CPU :-) could be ignored.
 > > Why on earth would you want to do that ?
 > > It wouldn't buy you anything at all other than a world of pain.
 > faster IO-MMU operations

huh ? You're talking about saving a handful of pci config space writes
per every insertion/removal of entries in that GATT, which need a cpu
cache flush anyway.

		Dave

