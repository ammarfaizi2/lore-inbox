Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268315AbUJURTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268315AbUJURTO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 13:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270746AbUJURQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 13:16:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:27290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270692AbUJURKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 13:10:54 -0400
Date: Thu, 21 Oct 2004 10:10:19 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Len Brown <len.brown@intel.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Versioning of tree
In-Reply-To: <4177E8A0.2090508@pobox.com>
Message-ID: <Pine.LNX.4.58.0410211005320.2171@ppc970.osdl.org>
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe>
 <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <4177E8A0.2090508@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Oct 2004, Jeff Garzik wrote:
> 
> The nightly snapshots have been exporting this info since Day One, based 
> on your request ;-)

Yes. But that doesn't help the people who actually use the native BK trees 
themselves, or the people who use the CVS exports. That was what Ben was 
complaining about. 

We already have the concept of "localversion*" files that get appended to 
the build. So the only thing that would be needed is some Makefile magic 
to create a "localversion-bk-version" file if the top-of-tree isn't 
tagged, and we'd get some unique ID for native BK users too.

		Linus
