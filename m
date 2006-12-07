Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032320AbWLGPxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032320AbWLGPxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032325AbWLGPxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:53:38 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:4575 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032320AbWLGPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:53:37 -0500
Date: Thu, 7 Dec 2006 16:53:36 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/5] PCI MMConfig: Share what's shareable.
Message-ID: <20061207155336.GA50797@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Muli Ben-Yehuda <muli@il.ibm.com>, Andi Kleen <ak@suse.de>,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207144952.GA45089@dspnet.fr.eu.org> <20061207150023.GH28515@rhun.haifa.ibm.com> <20061207151941.GA45592@dspnet.fr.eu.org> <20061207153506.GJ28515@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207153506.GJ28515@rhun.haifa.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 05:35:06PM +0200, Muli Ben-Yehuda wrote:
> arch/i386/pci/pci.h seems the least-inappropriate.

Ok, will do.


> Also, forgot to mention, please get rid of C++ style comments in the
> code.

# git grep '//' -- '*.c' |fgrep -v 'http://' |wc -l
14333

You lost that war ages ago.  Come join us in this millenia,
line-comments exist officially in C since 1999, and were supported way
before that.

  OG.
