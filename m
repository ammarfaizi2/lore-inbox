Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVKARtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVKARtG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVKARtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:49:05 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:30491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751052AbVKARtE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:49:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LFF2GwVCCqdB88VbLz10BBOoyw4cnhN4cpBluXvH4XmayG03ZduQjL3cKmSWkni2AIwv63xbBe5B0yyQ819tRFXDGgd+MPRcXtSiq4FI9gmq4qQ5onLW2xQAa6lwtp3a3v1yamt37U6oQQ7CKrhvNa9c8ZvGJue7VlXo/Otc7UI=
Message-ID: <5449aac20511010949x5d96c7e0meee4d76a67a06c01@mail.gmail.com>
Date: Tue, 1 Nov 2005 17:49:03 +0000
From: Alexander Fisher <alexjfisher@gmail.com>
Reply-To: alex@alexfisher.me.uk
To: linux-kernel@vger.kernel.org
Subject: Would I be violating the GPL?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

A supplier of a PCI mezzanine digital IO card has provided a linux 2.4
driver as source code.  They have provided this code source with a
license stating I won't redistribute it in anyway.
My concern is that if I build this code into a module, I won't be able
to distribute it to customers without violating either the GPL (by not
distributing the source code), or the proprietary source code license
as currently imposed by the supplier.
>From what I have read, this concern is only valid if the binary module
is considered to be a 'derived work' of the kernel.  The module source
directly includes the following kernel headers :

#include <linux/kernel.h>
#include <linux/types.h>
#include <linux/fs.h>
#include <linux/errno.h>
#include <linux/wrapper.h>
#include <linux/module.h>
#include <linux/iobuf.h>
#include <linux/highmem.h>
#include <asm/uaccess.h>
#include <linux/mm.h>
#include <asm/unistd.h>

Does this make the compiled module a derived work?  Are the 'static
inlines' from the headers substantial enough?

I really want to have a clear understanding of the issues before
contacting the supplier.  Any advice would be very much appreciated.
Kind regards,
Alex
