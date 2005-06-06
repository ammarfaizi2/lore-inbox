Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVFFScC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVFFScC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 14:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVFFScC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 14:32:02 -0400
Received: from 203-217-18-196.perm.iinet.net.au ([203.217.18.196]:3509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261617AbVFFSb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 14:31:59 -0400
Message-ID: <42A4969D.9070500@knobbits.org>
Date: Tue, 07 Jun 2005 04:31:57 +1000
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050524 Debian/1.7.8-1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Inspiron 6000 / ACPI S3 / PCI-X problems?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 I think this is my first ever post to l-k.

I'm scared.

I've been trying desperately to get suspend-to-ram working on my new 
inspiron 6000.

So far, the patch at

http://lkml.org/lkml/2005/5/23/116

Got the hard disk working after resume, and at least the b44 ethernic 
keeps working, but the display doesn't.  No amount of vbetool voodoo 
seems to bring it back up

Turns out the PCI config for the card gets trashed:

http://knobbits.org/archived/2005-06/lspci-i6000-before
http://knobbits.org/archived/2005-06/lspci-i6000-after

It's an ATI radeon M300, on a PCI-X bridge I think.

Is this a kernel issue or an X issue?  I vaguely recall some pci config 
save/restore hack floating around somewhere, should I try that?

This is ubuntu breezy, using xorg and kernel image 2.6.11.93-1.1

Mick.

