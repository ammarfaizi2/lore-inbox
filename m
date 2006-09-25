Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWIYL3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWIYL3H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 07:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWIYL3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 07:29:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34246 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751382AbWIYL3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 07:29:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060925110437.GD25449@flint.arm.linux.org.uk> 
References: <20060925110437.GD25449@flint.arm.linux.org.uk>  <20060924223925.GU29920@ftp.linux.org.uk> <22314.1159181060@warthog.cambridge.redhat.com> <1159183568.11049.51.camel@localhost.localdomain> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>,
       Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] restore libata build on frv 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 25 Sep 2006 12:28:22 +0100
Message-ID: <5602.1159183702@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> Note that if you don't provide an asm/libata-portmap.h file, you can't
> build libata at the moment - linux/libata.h requires this file to be
> present.

Yes, but it should be empty as there is no ISA bus.

David
