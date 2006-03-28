Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWC1Upq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWC1Upq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWC1Upq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:45:46 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49619 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932190AbWC1Upp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:45:45 -0500
Subject: Re: 2.6.16-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060328154246.GA18266@infradead.org>
References: <20060328003508.2b79c050.akpm@osdl.org>
	 <20060328154246.GA18266@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 28 Mar 2006 21:53:02 +0100
Message-Id: <1143579182.17522.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-28 at 16:42 +0100, Christoph Hellwig wrote:
> > +make-tty_insert_flip_char-a-non-gpl-export.patch
> 
> the argumentation is wrong.  the previous code beein inline made drivers
> using it even more of a derived work than a _GPL export.  

You shouldn't take it that way. My full message to Andrew for public
record was as follows

--

Based on Linus original comments about _GPL we should export
tty_insert_flip_char as EXPORT_SYMBOL because it used to be
EXPORT_SYMBOL equivalent (trivial inline). The other features are new
extensions are were not available to drivers before so need not be
provided except as _GPL functionality as far as I can see.

None of the above should be taken as permission directly, indirectly or
by means such as estoppel of the waving of GPL rights and me giving
permission for non-GPL code to use any of my GPL code if it is in any
way derivative of my work of course.

--

So if its derivative then so be it.

Alan

