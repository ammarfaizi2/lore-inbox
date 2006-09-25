Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWIYQOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWIYQOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 12:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWIYQOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 12:14:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751105AbWIYQOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 12:14:48 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1159199184.11049.93.camel@localhost.localdomain> 
References: <1159199184.11049.93.camel@localhost.localdomain>  <20060925142016.GI29920@ftp.linux.org.uk> <1159186771.11049.63.camel@localhost.localdomain> <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> <7276.1159186684@warthog.cambridge.redhat.com> <20660.1159195152@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 17:04:10 +0100
Message-ID: <22596.1159200250@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ack Al Viro's changes but with IRQ set to zero.

The PCI bus has special mappings.  You may not address it with those numbers.
Any of those numbers.  Al's patch is 100% incorrect.  Sorry.

David
