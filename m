Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271077AbUJUXRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271077AbUJUXRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271084AbUJUXPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:15:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S271089AbUJUXD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:03:28 -0400
Message-ID: <41784034.9050107@pobox.com>
Date: Thu, 21 Oct 2004 19:03:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@osdl.org>
Subject: kbuild (was Re: Versioning of tree)
References: <1098254970.3223.6.camel@gaston> <1098256951.26595.4296.camel@d845pe> <Pine.LNX.4.58.0410200728040.2317@ppc970.osdl.org> <4177E8A0.2090508@pobox.com> <Pine.LNX.4.58.0410211005320.2171@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410211005320.2171@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> We already have the concept of "localversion*" files that get appended to 
> the build.[...]


Just to tangent a bit...  I've been meaning to throw out a public kudos 
to Sam, Kai, Roman and the other kbuild/kconfig hackers.  The 2.6 kbuild 
and kconfig system is a _huge_ improvement over 2.4.x.

These days I use
	echo "-sataN" > localversion
heavily, and it's been quite helpful.  The separation of src/obj 
directories, the default verbosity level, 'make allyesconfig', and the 
elimination of recursive Makefile invocations are just some of the 
things that stick out as positive improvements that impact me on a daily 
basis.

Thanks guys!

	Jeff


