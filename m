Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267440AbUHDVaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267440AbUHDVaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHDVaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 17:30:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267440AbUHDV2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 17:28:14 -0400
Date: Wed, 4 Aug 2004 17:28:06 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@dhcp83-102.boston.redhat.com
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <chrisw@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mlock-as-user for 2.6.8-rc2-mm2
In-Reply-To: <20040804212228.GA23054@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0408041727140.9630-100000@dhcp83-102.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Arjan van de Ven wrote:
> On Wed, Aug 04, 2004 at 02:24:01PM -0700, Andrew Morton wrote:

> > Can you think of some way in which we can artificially tweak the patch
> > for testing so that its new features are getting some exercise?
> 
> gpg uses mlock (well it tries to) which is why the fedora patch has a
> 4Kb default ;)

I guess we need to figure out how much memory gpg mlocks by
default (16kB?) and set the default rlimit to that.  Then
every gpg user out there will automatically test the code ;)

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

