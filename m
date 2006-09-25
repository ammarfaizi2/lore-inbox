Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWIYMTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWIYMTi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 08:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWIYMTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 08:19:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25325 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751143AbWIYMTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 08:19:38 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1159186771.11049.63.camel@localhost.localdomain> 
References: <1159186771.11049.63.camel@localhost.localdomain>  <1159183568.11049.51.camel@localhost.localdomain> <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <5578.1159183668@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@ftp.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 13:18:04 +0100
Message-ID: <7276.1159186684@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Wrong these are PCI settings. Please read the PCI specifications. In
> particular the handling of non-native mode IDE storage class devices on
> a PCI bus. For the IRQ mapping of the non-native ports consult your
> bridge documentation.

Even if that is the case, they are all invalid/incorrect, and so Al Viro's
patch is _still_ NAK'd.

David
